require "spec_helper"

describe "Viewing the list of projects" do
  it "shows the projects" do
    # Arrange
    project1 = Project.create(name: "Core System Migration",
                              description: "Migrating from a legacy core system to a modern core system",
                              target_pledge_amount: 50000.00,
                              pledging_ends_on: 2.weeks.from_now.to_date,
                              #pledging_ends_on: 14.days.from_now.to_date,
                              website: "http://www.systemmigration.com",
                              team_members: "John Doe, Mary Jane",
                              #image_file_name: "csm.jpg",
                              image: open("#{Rails.root}/app/assets/images/project-a.png"))  
    project2 = Project.create(name: "Distribution Compensation System",
                              description: "Implementing a new compensation system for distributors",
                              target_pledge_amount: 18000.00,
                              pledging_ends_on: 5.days.ago,
                              website: "http://www.distributioncompenstation.com",
                              team_members: "Jacky Young, May Ferng",
                              #image_file_name: "dcs.jpg",
                              image: open("#{Rails.root}/app/assets/images/project-b.png"))
    project3 = Project.create(name: "Mobile Insurance",
                              description: "Mobile insurance quotation and submission",
                              target_pledge_amount: 12000.00,
                              pledging_ends_on: 2.months.from_now,
                              website: "http://www.mobileinsurance.com",
                              team_members: "Han Yiew, Lynn Siaow",
                              #image_file_name: "mi.jpg",
                              image: open("#{Rails.root}/app/assets/images/project-c.png"))
    
    # Action
    visit projects_url

    # Assert
    #expect(page).to have_text("2 Projects") # One of them was done
    expect(page).to have_text(project1.name)
    expect(page).not_to have_text(project2.name)
    expect(page).to have_text(project3.name)

    expect(page).to have_text(project1.description[0..19])
    expect(page).to have_text("$50,000.00")
    expect(page).to have_text("14 days remaining")
    #expect(page).to have_selector("img[src$='#{project1.image_file_name}']")
    expect(page).to have_selector("img[src$='#{project1.image.url}']")
  end

  it "does not show a project that is no longer accepted pledges" do
    # Arrange
    project = Project.create(project_attributes(pledging_ends_on: 1.day.ago))

    # Action
    visit projects_path

    # Assert
    expect(page).not_to have_text(project.name)
  end
end
