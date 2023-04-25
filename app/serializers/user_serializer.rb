class UserSerializer
  include JSONAPI::Serializer

  def self.format_user(user)
    {
      data: {
        type: "users",
        id: user.id.to_s,
        attributes: {
          email: user.email,
          api_key: user.api_key
        }
      }
    }
  end
end