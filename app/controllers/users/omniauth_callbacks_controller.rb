module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: %i[google_oauth2 cognito_idp]

    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        redirect_to root_path
        set_flash_message(:notice, :success, kind: 'Google')
      else
        redirect_to new_user_session_url
        set_flash_message(:notice, :failure, kind: 'Google', reason: 'login')
      end
    end

    def cognito_idp
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        redirect_to root_path
        set_flash_message(:notice, :success, kind: 'Cognito')
      else
        redirect_to new_user_session_url
        set_flash_message(:notice, :failure, kind: 'Cognito', reason: 'login')
      end
    end
  end
end
