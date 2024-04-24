class SessionsController < ApplicationController
  def omniauth
    @user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |user|
      user.email = auth['info']['email']
    end

    redirect_to root_path if @user.valid?
  end

  private

  def auth = request.env['omniauth.auth']
end
