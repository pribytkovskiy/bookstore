class AddressForm
  include ActiveModel::Model
  include Virtus.model

  ONLY_LETTERS = /\A[а-яА-ЯёЁa-zA-Z]+\z/.freeze
  ONLY_NUMBERS = /\A[0-9]+\z/.freeze
  STARTS_WITH_PLUS = /\A^\+[0-9]+\z/.freeze
  ADDRESS_TYPE = { billing: 'billing', shipping: 'shipping' }.freeze

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :phone, String
  attribute :city, String
  attribute :country, String
  attribute :check, String
  attribute :order_id, Integer
  attribute :user_id, Integer
  attribute :zip, Integer
  attribute :address_type, String

  attr_accessor :check

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :zip, presence: true
  validates :first_name, :last_name, :address, :city, :country, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  validates :zip, length: { maximum: 5 }, format: { with: ONLY_NUMBERS, message: I18n.t('only_numbers') }
  validates :phone, length: { maximum: 15 }, format: { with: STARTS_WITH_PLUS, message: I18n.t('starts_with_plus') }

  def save
    return false unless valid?

    persist!
    true
  end

  private

  def set_order
    Order.find_by(id: order_id)
  end

  def set_user
    User.find_by(id: user_id)
  end

  def set_inst_save
    return set_order if order_id

    set_user if user_id
  end

  def persist!
    return save_address_shipping(set_inst_save) if check || address_type == ADDRESS_TYPE[:shipping]

    save_address_billing(set_inst_save) if address_type == ADDRESS_TYPE[:billing]
  end

  def save_address_billing(inst_save)
    if inst_save.addresses.billing.exists?
      inst_save.addresses.billing.last.update(address_params(ADDRESS_TYPE[:billing]))
    else
      inst_save.addresses.billing.create(address_params(ADDRESS_TYPE[:billing]))
    end
  end

  def save_address_shipping(inst_save)
    if inst_save.addresses.shipping.exists?
      inst_save.addresses.shipping.last.update(address_params(ADDRESS_TYPE[:shipping]))
    else
      inst_save.addresses.shipping.create(address_params(ADDRESS_TYPE[:shipping]))
    end
  end

  def address_params(type)
    {
      first_name: first_name,
      last_name: last_name,
      address: address,
      city: city,
      zip: zip,
      country: country,
      phone: phone,
      address_type: type
    }
  end
end
