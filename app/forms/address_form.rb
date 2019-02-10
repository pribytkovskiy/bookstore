class AddressForm
  include ActiveModel::Model
  include Virtus.model

  STRING_ATTRS = %i[first_name last_name address phone city country shipping_first_name shipping_last_name shipping_address shipping_city shipping_country shipping_phone].freeze
  ONLY_LETTERS = /\A[а-яА-ЯёЁa-zA-Z]+\z/
  ONLY_NUMBERS = /\A[0-9]+\z/
  STARTS_WITH_PLUS = /\A^\+[0-9]+\z/

  STRING_ATTRS.each do |name|
    attribute name, String
    validates name, presence: true
  end
  
  attribute :zip, Integer
  attribute :shipping_zip, Integer
  validates :zip, :shipping_zip, presence: true
  attribute :check, Boolean

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address, :city, :country, :phone, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  validates :zip, length: { maximum: 5 }, format: { with: ONLY_NUMBERS, message: I18n.t('only_numbers') }
  validates :phone, length: { maximum: 15 }, format: { with: STARTS_WITH_PLUS, message: I18n.t('starts_with_plus') }

  attr_reader :address

  def save
    copy_params # if check == 'true'
    return false unless valid?
    
    persist!
    true
  end

  private

  def copy_params
    shipping_first_name = first_name
    shipping_last_name = last_name
    shipping_address = address
    shipping_phone = phone
    shipping_city = city
    shipping_country = country
    shipping_zip = zip
  end

  def persist!
    @address_billing = Address.billing.create!(address_params_billing)
    return @address_shipping = Address.shipping.create!(address_params_billing) if check == 'true'

    @address_shipping = Address.shipping.create!(address_params_shipping)
  end

  def address_params_billing
    {
      first_name: first_name,
      last_name: last_name,
      address: address,
      phone: phone,
      city: city,
      country: country,
      zip: zip
    }
  end

  def address_params_shipping
    {
      first_name: shipping_first_name,
      last_name: shipping_last_name,
      address: shipping_address,
      phones: shipping_phones,
      city: shipping_city,
      country: shipping_country,
      zip: shipping_zip
    }
  end
end 
