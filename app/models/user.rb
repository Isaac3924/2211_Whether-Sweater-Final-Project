class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
 
  has_secure_password

  def find_by_email(email)
    User.find_by(email: email)
  end
end