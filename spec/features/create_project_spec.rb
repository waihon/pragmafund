describe "Create a new project" do
  it "saves the project and shows the new project's detai's" do
    # Arrange

    # Action
    visit projects_url
    click_link "Add New Project"

    # Assert
    expect(current_path).to eq(new_project_path)
    expect(find_field("Name").value).to eq(nil)

    # Action
    fill_in "Name", with: "New Project"
    fill_in "Description", with: "Description of the new project"
    fill_in "Target pledge amount", with: "12345.60"
    #fill_in "Pledging ends on", with: 15.days.from_now
    select (Time.now.year + 1).to_s, from: "project_pledging_ends_on_1i"
    fill_in "Website", with: "http://www.new-project.com"
    fill_in "Team members", with: "John Doe, Mary Jane"
    fill_in "Image filename", with: "newproject.jpg"

    click_button "Create Project"

    # Assert
    expect(current_path).to eq(project_path(Project.last))
    expect(page).to have_text("New Project")

    expect(page).to have_text("Project successfully created!")
  end

  it "does not save the proejct if it's invalid" do
    # Action
    visit new_project_url

    # Assert
    expect {
        click_button "Create Project"
    }.not_to change(Project, :count)

    expect(current_path).to eq(projects_path)
    expect(page).to have_text("error")
  end
end