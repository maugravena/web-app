class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, omniauth_providers: %i[google_oauth2 cognito_idp]

  def self.from_omniauth(auth)
    find_or_create_by!(email: auth.info.email, provider: auth.provider) do |user|
      user.uid = auth.uid
    end
  end
end