# rails g resource Pledge name:string email:string comment:text amount:decimal 
# project:references --no-test-framework
class Pledge < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true
  validates :email, format: { 
    with: /([A-Za-z0-9_\.-]+)@([\dA-Za-z\.-]+)\.([A-Za-z\.]{2,6})/ 
  }

  AMOUNT_LEVELS = [25, 50, 100, 200, 500]
  validates :amount, inclusion: { in: AMOUNT_LEVELS }
end
