# This file should contain all the record creation needed to seed the database 
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db 
# with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Project.create!([
  {
    name: "Start-Up Project",
    description: "A description of a start-up project",
    target_pledge_amount: 100.00,
    pledging_ends_on: 1.day.from_now,
    website: "http://project-a.com",
    team_members: "Amber, John, Charles",
    #image_file_name: "project-a.png"
    image: open("#{Rails.root}/app/assets/images/project-a.png")
  },
  {
    name: "Community Project",
    description: "A description of a community project",
    target_pledge_amount: 200.00,
    pledging_ends_on: 1.week.from_now,
    website: "http://project-b.com",
    team_members: "Diana, Jane, Joe",
    #image_file_name: "project-b.png"
    image: open("#{Rails.root}/app/assets/images/project-b.png")
  },
  {
    name: "Personal Project",
    description: "A description of a person project",
    target_pledge_amount: 300.00,
    pledging_ends_on: 1.month.from_now,
    website: "http://project-c.com",
    team_members: "Tom, Harry, Sally",
    #image_file_name: "project-c.png"
    image: open("#{Rails.root}/app/assets/images/project-c.png")
  },

  { name: "Core System Migration",
    description: "Migrating from a legacy core system to a modern core system",
    target_pledge_amount: 50000.00,
    pledging_ends_on: 2.weeks.from_now,
    website: "http://www.systemmigration.com",
    team_members: "Simon, Suan, Ken",
    #image_file_name: "project-d.png" 
    image: open("#{Rails.root}/app/assets/images/project-d.png")
  }, 
  { name: "Distribution Compensation System",
    description: "Implementing a new compensation system for distributors",
    target_pledge_amount: 18000.00,
    pledging_ends_on: 5.days.ago,
    website: "http://www.distributioncompenstation.com",
    team_members: "Jacky, May, Susan",
    #image_file_name: "project-e.png"
    image: open("#{Rails.root}/app/assets/images/project-e.png")
  },
  { 
    name: "Mobile Insurance",
    description: "Mobile insurance quotation and submission",
    target_pledge_amount: 12000.00,
    pledging_ends_on: 2.months.from_now,
    website: "http://www.mobileinsurance.com",
    team_members: "Daniel, Lynn, Han",
    #image_file_name: "project-f.png"
    image: open("#{Rails.root}/app/assets/images/project-f.png")
  }
])

project = Project.find_by(name: 'Start-Up Project')
project.pledges.create!(name: "Nicole", email: "nicole@gmail.com", amount: 25.00, 
  comment: "Great project!")
project.pledges.create!(name: "Mike", email: "mike@gmail.com", amount: 50.00, 
  comment: "IPO now!")