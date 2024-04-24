class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 cognito_idp]

  def self.from_omniauth(auth)
    find_or_create_by!(email: auth.info.email, provider: auth.provider) do |user|
      user.uid = auth.uid
      user.password = '1234567890'
    end
  end
end
