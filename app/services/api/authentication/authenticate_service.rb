class Api::Authentication::AuthenticateService < ApplicationService
  def call
    prepare_resource
  end

  private

  def prepare_resource
    JsonWebToken::encode(user_id: user.id) if user
  end

  def user
    user = User.find_by_name(user_name)
    user if user && user.authenticate(user_pass)
  end

  def user_name
    params[:name]
  end

  def user_pass
    params[:password]
  end
end
