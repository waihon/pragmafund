class Project < ActiveRecord::Base
  has_attached_file :image

  validates :name, presence: true
  validates :description, presence: true,
                          length: { maximum: 500}
  validates :target_pledge_amount, numericality: { greater_than: 0 }
  validates :website, allow_blank: true, format: {
    with: /(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/
    #with: /(?:https?:\/\/)?(?:[\w]+\.)([a-zA-Z\.]{2,6})([\/\w\.-]*)*\/?/
  }
  # validates :image_file_name, allow_blank: true, format: {
  #   with: /\w+\.(gif|jpg|png)\z/i,
  #   message: "must reference a GIF, JPG, or PNG image"
  # }
  validates_attachment :image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { less_than: 1.megabyte} 

  has_many :pledges, dependent: :destroy

  def self.active
    where("pledging_ends_on > ?", Time.now).order(pledging_ends_on: :asc)
  end

  def pledging_expired?
    pledging_ends_on < Date.today
  end

  def total_amount_pledged
    pledges.sum(:amount)
  end

  def amount_outstanding
    target_pledge_amount - pledges.sum(:amount)
  end

  def funded?
    amount_outstanding <= 0.00
  end

  def recent_pledges
    pledges.order(created_at: :desc).limit(2)
  end
end
