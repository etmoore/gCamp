class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :comments

  def full_name
    "#{first_name} #{last_name}"
  end
end
