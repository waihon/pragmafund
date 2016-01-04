describe "Viewing an individual project" do
  it "show the project's details" do
    # Arrange
    project = Project.create(name: "Project A", 
                             description: "A description for Project A", 
                             target_pledge_amount: 12345.60, 
                             website: "http://www.project-a.com", 
                             pledging_ends_on: 15.days.from_now.to_date,
                             team_members: "John Doe, Mary Jane",
                             image_file_name: "projecta.jpg")

    # Action
    visit project_url(project)

    # Assert
    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$12,345.60")
    expect(page).to have_text(project.website)
    #expect(page).to have_text(project.pledging_ends_on)
    expect(page).to have_text("15 days remaining")
    expect(page).to have_text(project.team_members)
    expect(page).to have_selector("img[src$='#{project.image_file_name}']")
  end

  it "shows the number of days remaining if the pledging end date is in the future" do
    # Arrange
    project = Project.create(project_attributes(pledging_ends_on: 1.day.from_now.to_date))

    # Action
    visit project_url(project)

    # Assert
    expect(page).to have_text("1 day remaining")
  end

  it "show 'Add Done!' if the pledging end date is in the past" do
    # Arrange
    project = Project.create(project_attributes(pledging_ends_on: 1.day.ago))

    # Action
    visit project_url(project)

    # Assert
    expect(page).to have_text("All Done!")
  end

  it "shows the amount outstanding with a pledge link if the project is not funded" do
    # Arrange
    project = Project.create(project_attributes(target_pledge_amount: 1000))
    Pledge::AMOUNT_LEVELS.each do |amount|
      project.pledges.create!(pledge_attributes(amount: amount))
    end

    # Action
    visit project_url(project)

    # Assert
    expect(page).to have_text("Only $125 left!")
    expect(page).to have_link("Pledge!", href: new_project_pledge_path(project))
    expect(page).not_to have_text("Funded!")
  end

  it "shows 'Funded' without a pledge link if the project is funded" do
    # Arrange
    project = Project.create(project_attributes(target_pledge_amount: 875))
    Pledge::AMOUNT_LEVELS.each do |amount|
      project.pledges.create!(pledge_attributes(amount: amount))
    end

    # Action
    visit project_url(project)

    # Assert
    expect(page).to have_text("Funded!")
    expect(page).not_to have_link("Pledge!", href: new_project_pledge_path(project))
  end
end