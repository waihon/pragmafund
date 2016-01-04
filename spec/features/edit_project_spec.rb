describe "Editing a project" do
  it "updates the project and shows the project's updated details" do
    # Arrange
    project = Project.create(project_attributes(target_pledge_amount: 123456.78))

    # Action
    visit project_url(project)
    click_link "Edit"

    # Assert
    expect(current_path).to eq(edit_project_path(project))
    expect(find_field("Name").value).to eq(project.name)
    expect(find_field("Description").value).to eq(project.description)
    expect(find_field("Website").value).to eq(project.website)
    expect(find_field("Target pledge amount").value.to_s).to eq(project.target_pledge_amount.to_s)
    # TODO: expect(find_field("Pledging ends on").value).to eq(project.pledging_ends_on)  
    expect(find_field("project_pledging_ends_on_1i").value.to_s).to eq(project.pledging_ends_on.year.to_s)  
    expect(find_field("project_pledging_ends_on_2i").value.to_s).to eq(project.pledging_ends_on.month.to_s)
    expect(find_field("project_pledging_ends_on_3i").value.to_s).to eq(project.pledging_ends_on.day.to_s)

    # Action
    fill_in "Name", with: "Updated Project Name"
    click_button "Update Project"

    # Assert
    expect(current_path).to eq(project_path(project))
    expect(page).to have_text("Updated Project Name")

    expect(page).to have_text("Project successfully updated!")
  end

  it "does not update the project if it's invalid" do
    # Arrange
    project = Project.create(project_attributes)

    # Action
    visit edit_project_url(project)
    fill_in "Name", with: ""
    click_button "Update Project"

    # Assert
    expect(current_path).to eq(project_path(project))
    expect(page).to have_text("error")
  end
end