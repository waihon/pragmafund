def project_attributes(overrides = {})
  {
    name: "Project A", 
    description: "A description for Project A", 
    target_pledge_amount: 12345.60, 
    website: "http://www.project-a.com", 
    pledging_ends_on: 15.days.from_now,
    website: "http://project-a.com",
    #image_file_name: "projecta.jpg"
    image: open("#{Rails.root}/app/assets/images/project-a.png")
  }.merge(overrides)
end

def pledge_attributes(overrides = {})
  {
    name: "John Doe", 
    email: "john@example.com", 
    comment: "This is a project worth pledging for.",
    amount: 50.00
  }.merge(overrides)
end