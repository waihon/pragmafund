describe "Deleting a project" do
  it "destroys the project and shows the project listing without the project" do
    # Arrange
    project = Project.create(project_attributes)

    # Action
    visit project_path(project)
    click_link "Delete"

    # Assert
    expect(current_path).to eq(projects_path)
    expect(page).not_to have_text(project.name)

    expect(page).to have_text("Project successfully deleted!")
  end
end