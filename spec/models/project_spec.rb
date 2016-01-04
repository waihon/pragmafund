describe "A project" do
  it "has expired if the pledging ends on date is in the past" do
    # Arrange
    project = Project.new(pledging_ends_on: 1.day.ago)

    # Assert
    expect(project.pledging_expired?).to eq(true)
  end

  it "has not expired if the pledging ends on date is in the future" do
    # Arrange
    project = Project.new(pledging_ends_on: 1.day.from_now)

    # Assert
    expect(project.pledging_expired?).to eq(false)
  end

  it "requires a name" do
    # Arrange
    project = Project.new(name: "")

    # Action
    project.valid?

    # Assert
    expect(project.errors[:name].any?).to eq(true)
  end

  it "requires a description" do
    # Arrange
    project = Project.new(description: "")

    # Action
    project.valid?

    # Assert
    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts a description up to 500 characters" do
    # Arrange
    project = Project.new(description: "X" * 500)

    # Action
    project.valid?

    # Assert
    expect(project.errors[:description].any?).to eq(false)
  end

  it "rejects a description more than 500 characters" do
    # Arrange
    project = Project.new(description: "X" * 501)

    # Action
    project.valid?

    # Assert
    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts a positive target pledge amount" do
    # Arrange
    project = Project.new(target_pledge_amount: 0.01)

    # Action
    project.valid?

    # Assert
    expect(project.errors[:target_pledge_amount].any?).to eq(false)
  end

  it "rejects a $0 target pledge amount" do
    # Arrange
    project = Project.new(target_pledge_amount: 0.00)

    # Action
    project.valid?

    # Assert
    expect(project.errors[:target_pledge_amount].any?).to eq(true)
  end

  it "rejects a negative target pledge amount" do
    # Arrange
    project = Project.new(target_pledge_amount: -0.01)

    # Action
    project.valid?

    # Assert
    expect(project.errors[:target_pledge_amount].any?).to eq(true)
  end

  it "accepts properly formatted website URLs" do
    # Arrange
    sites = %w[http://www.projecta.com https://project-b.com http://project-c.startups.com.my 
      project-c.startups.com.my]
    sites.each do |site|
      project = Project.new(website: site)

      # Action
      project.valid?

      # Assert
      expect(project.errors[:website].any?).to eq(false)
    end
  end

  it "rejects improperly formatted website URLs" do
    # Arrange
    #sites = %w[http://projectd projectc http http://www.projecta.c http://www.projecta.cooooom]
    sites = %w[http://projectd projectc http]
    sites.each do |site|
      project = Project.new(website: site)

      # Action
      project.valid?

      # Assert
      expect(project.errors[:website].any?).to eq(true)
    end
  end

  # Paperclip will manage its own image attribute
  # it "accepts properly formatted image file names" do
  #   # Arrange
  #   image_file_names = %w[projecta.jpg projectb.png project-c.gif p.gif PROJECTD.GIF]
  #   image_file_names.each do |file_name|
  #     project = Project.new(image_file_name: file_name)

  #     # Action
  #     project.valid?

  #     # Assert
  #     expect(project.errors[:image_file_name].any?).to eq(false)
  #   end
  # end

  # it "rejects improperly formatted image file names" do
  #   # Arrange
  #   image_file_names = %w[projecta.doc projectb.pdf project-c.tiff project .jpg .png .gif]
  #   image_file_names.each do |file_name|
  #     project = Project.new(image_file_name: file_name)

  #     # Action
  #     project.valid?

  #     # Assert
  #     expect(project.errors[:image_file_name].any?).to eq(true)
  #   end
  # end

  it "has many pledges" do
    # Arrange
    project = Project.new(project_attributes)

    pledge1 = project.pledges.new(pledge_attributes)
    pledge2 = project.pledges.new(pledge_attributes)

    # Assert
    expect(project.pledges).to include(pledge1)
    expect(project.pledges).to include(pledge2)
  end

  it "deletes associated pledges" do
    project = Project.create(project_attributes)

    project.pledges.create(pledge_attributes)

    expect {
      project.destroy
    }.to change(Pledge, :count).by(-1)
  end

  it "calculates the total amount pledged as the sum of all the pledges" do
    # Arrange
    project = Project.create(project_attributes)
    Pledge::AMOUNT_LEVELS.each do |amount|
      project.pledges.create!(pledge_attributes(amount: amount))
    end

    # Assert
    expect(project.total_amount_pledged).to eq(875)
  end

  it "calculates the pledge amount outstanding" do
    # Arrange
    project = Project.create(project_attributes(target_pledge_amount: 1500))
    Pledge::AMOUNT_LEVELS.each do |amount|
      project.pledges.create!(pledge_attributes(amount: amount))
    end

    # Assert
    expect(project.amount_outstanding).to eq(625)
  end

  it "is funded if the target pledge amount has been reached" do
    # Arrange
    project = Project.create(project_attributes(target_pledge_amount: 875))
    Pledge::AMOUNT_LEVELS.each do |amount|
      project.pledges.create!(pledge_attributes(amount: amount))
    end

    # Assert
    expect(project.funded?).to eq(true)
  end

  it "is not funded if the target pledge amount has not been reached" do
    # Arrange
    project = Project.create(project_attributes(target_pledge_amount: 875.01))
    Pledge::AMOUNT_LEVELS.each do |amount|
      project.pledges.create!(pledge_attributes(amount: amount))
    end

    # Assert
    expect(project.funded?).to eq(false)
  end
end
