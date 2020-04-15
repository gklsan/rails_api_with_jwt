class AuthenticateUser
  attr_accessor :email, :password
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private
  def user
    user = User.find_by_email(@email)
    return user if user&.authenticate(password)

    errors.add(:user_authetication, 'Invalid username or password')
  end
end
