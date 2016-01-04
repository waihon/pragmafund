describe "Creating a new pledge" do
  it "saves the pledge if it's valid" do
    # Arrange
    project = Project.create(project_attributes)

    # Action
    visit project_url(project)
    click_link "Pledge!"

    # Assert
    expect(current_path).to eq(new_project_pledge_path(project))

    # Action
    fill_in "Name", with: "Joe Smith"
    fill_in "Email", with: "joe@gmail.com"
    #select "100", from: "project_amount"
    choose "pledge_amount_100" 
    fill_in "Comment", with: "Count me in!"
    click_button "Create Pledge"

    # Assert
    expect(current_path).to eq(project_pledges_path(project))
    expect(page).to have_text("Thanks for pledging!")
    expect(page).to have_text("Joe Smith")
    expect(page).to have_text("$100.00")
    expect(page).to have_text("Count me in!")
  end

  it "does not save the pledge if it's invalid" do
    # Arrange
    project = Project.create(project_attributes)

    # Action
    visit project_url(project)
    click_link "Pledge!"
    fill_in "Name", with: "Joe Smith"
    
    # Assert
    expect {
      click_button "Create Pledge"
    }.not_to change(Pledge, :count)

    expect(current_path).to eq(project_pledges_path(project))
    expect(page).to have_text("error")
  end
end