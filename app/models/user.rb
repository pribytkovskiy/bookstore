class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  has_many :orders

  devise :omniauthable, omniauth_providers: [:facebook]

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true, on: :update
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, length: { maximum: 50 }, on: :update
  validates :first_name, :last_name, :city, :country,
            format: { with: /\A[а-яА-ЯёЁa-zA-Z]+\z/, message: 'only allows letters' }, on: :update
  validates :zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: 'only allows numbers' }, on: :update
  validates :phone, length: { maximum: 15 },
            format: { with: /\A^\+[0-9]+\z/, message: 'should starts with +' }, on: :update
  validates :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city,
            :shipping_zip, :shipping_country, :shipping_phone, presence: true, on: :update
  validates :shipping_first_name, :shipping_last_name, :shipping_address,
            :shipping_city, :shipping_zip, :shipping_country, :shipping_phone, length: { maximum: 50 }, on: :update
  validates :shipping_first_name, :shipping_last_name, :shipping_city, :shipping_country,
            format: { with: /\A[а-яА-ЯёЁa-zA-Z]+\z/, message: 'only allows letters' }, on: :update
  validates :shipping_zip, length: { maximum: 10 },
            format: { with: /\A[0-9]+\z/, message: 'only allows numbers' }, on: :update
  validates :shipping_phone, length: { maximum: 15 },
            format: { with: /\A^\+[0-9]+\z/, message: 'should starts with +' }, on: :update

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
end
