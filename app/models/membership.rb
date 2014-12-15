class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :role, presence: true
  validates :user, presence: true, uniqueness: {scope: :project, message: "has already been added to project"}

  def owner?
    self.role == "owner"
  end
end
