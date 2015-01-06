class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :tracker_token, length: {is: 32}, allow_blank: true
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :projects, through: :memberships

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    admin
  end

  def censored_token
    return false if tracker_token.length == 0
    tracker_token[0..3] + ( '*' * tracker_token[4..-1].length)
  end
end
