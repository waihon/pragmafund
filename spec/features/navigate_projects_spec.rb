describe "Navigating projects" do
  it "allows navigaton from the detail page to the listing page" do
    # Arrange
    project = Project.create(project_attributes)

    # Action
    visit project_url(project)
    click_link "All Projects"

    # Assert
    expect(current_path).to eq(projects_path)
  end

  it "allows navigation from the listing page to the detail page" do
    # Arrange
    project = Project.create(project_attributes)

    # Action
    visit projects_url
    click_link project.name

    # Assert
    expect(current_path).to eq(project_path(project))
  end
end