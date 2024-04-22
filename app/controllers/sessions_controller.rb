class SessionsController < ApplicationController
  def omniauth
    @user = User.find_or_create_by(uid:, provider:) do |user|
      user.email = email
    end

    redirect_to root_path if @user.valid?
  end

  private

  def auth = request.env['omniauth.auth']
  def uid = auth['uid']
  def provider = auth['provider']
  def email = auth['info']['email']
end
