module ProjectsHelper
  def format_pledging_ends_on(project)
    if project.pledging_expired?
      content_tag(:strong, "All Done!")
    else
      distance_of_time_in_words(Date.today, project.pledging_ends_on) + " remaining"
    end
  end

  def image_for(project)
    if project.image_file_name.blank?
      image_tag("placeholder.png")
    else
      image_tag(project.image_file_name)
    end
  end

  def format_amount_outstanding(project)
    if project.funded?
      content_tag(:strong, "Funded!")
    else
      "Only #{number_to_currency(project.amount_outstanding, precision: 0)} left!"
    end
  end

  def format_pledge_button(project)
    if !project.funded?
      link_to "Pledge!", new_project_pledge_path(project), class: "button ok pledge"
    end
  end
end