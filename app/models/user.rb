class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  has_many :orders
  has_many :comments, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split(' ')[0]
      user.last_name = auth.info.name.split(' ')[1]
      user.pictures = auth.info.image
      user.save
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def role?(rol)
    role ? (role.include? rol.to_s) : false
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
end
