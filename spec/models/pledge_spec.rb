describe "A pledge" do
  it "belongs to a project" do
    # Arrange
    project = Project.create(project_attributes)
    pledge = project.pledges.new(pledge_attributes)

    # Assert
    expect(pledge.project).to eq(project)
  end

  it "requires a name" do
    # Arrange
    pledge = Pledge.new(name: "")

    # Action
    pledge.valid?

    # Assert
    expect(pledge.errors[:name].any?).to eq(true)
  end

  it "requires an email" do
    # Arrange
    pledge = Pledge.new(email: "")

    # Action
    pledge.valid?

    # Assert
    expect(pledge.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted emails" do
    # Arrange
    emails = %w[user@example.com USER@example.com first.last@example.com]
    emails.each do |email|
      pledge = Pledge.new(email: email)

      # Action
      pledge.valid?

      # Assert
      expect(pledge.errors[:email].any?).to eq(false)
    end
  end

  it "rejects impropery formatted emails" do
    # Arrange
    emails = %w[user user_at_example.com @example.]
    emails.each do |email|
      pledge = Pledge.new(email: email)

      # Action
      pledge.valid?

      # Assert
      expect(pledge.errors[:email].any?).to eq(true)
    end
  end

  it "accepts valid amounts" do
    # Arrange
    amounts = Pledge::AMOUNT_LEVELS
    amounts.each do |amount|
      pledge = Pledge.new(amount: amount)

      # Action
      pledge.valid?

      # Assert
      expect(pledge.errors[:amount].any?).to eq(false)
    end
  end

  it "rejects invalid amounts" do
    # Arrange
    amounts = [-10.00, 0.00, 13.00]
    amounts.each do |amount|
      pledge = Pledge.new(amount: amount)

      # Action
      pledge.valid?

      # Assert
      expect(pledge.errors[:amount].any?).to eq(true)
    end
  end
end