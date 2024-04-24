module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: %i[google_oauth2 cognito_idp]

    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in_and_redirect(@user, event: :authentication)
        set_flash_message(:notice, :success, kind: 'Google')
      end
    end

    def cognito_idp
      @user = User.from_omniauth(request.env['omniauth.auth'])

      return unless @user.persisted?

      sign_in_and_redirect(@user, event: :authentication)
      set_flash_message(:notice, :success, kind: 'Cognito')
    end
  end
end
