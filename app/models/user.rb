class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
 
  has_secure_password

  def find_by_email(email)
    User.find_by(email: email)
  end

  def find_by_api(api_key)
    User.find_by(api_key: api_key)
  end
end