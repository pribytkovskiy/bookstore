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

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, :address, :city, :country, :phone, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  validates :zip, length: { maximum: 5 }, format: { with: ONLY_NUMBERS, message: I18n.t('only_numbers') }
  validates :phone, length: { maximum: 15 }, format: { with: STARTS_WITH_PLUS, message: I18n.t('starts_with_plus') }

  attr_reader :address

  def save
    return false unless valid?
    persist!
    true
  end

  def persist!
    @address = Address.create!(address_params) # address + order_id
  end
end 
