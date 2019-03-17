class AddressForm
  include ActiveModel::Model
  include Virtus.model

  ONLY_LETTERS = /\A[а-яА-ЯёЁa-zA-Z]+\z/
  ONLY_NUMBERS = /\A[0-9]+\z/
  STARTS_WITH_PLUS = /\A^\+[0-9]+\z/
  
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

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :zip, presence: true
  validates :first_name, :last_name, :address, :city, :country, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  validates :zip, length: { maximum: 5 }, format: { with: ONLY_NUMBERS, message: I18n.t('only_numbers') }
  validates :phone, length: { maximum: 15 }, format: { with: STARTS_WITH_PLUS, message: I18n.t('starts_with_plus') }

  def save
    set_order
    return false unless valid?

    persist!
    true
  end

  private

  def set_order
    @order = Order.find_by(id: order_id)
  end

  def persist!
    save_address_billing if address_type = :billing
    save_address_shipping if address_type = :shipping
  end

  def save_address_billing
    if @order.addresses.billing.exists?
      @order.addresses.billing.last.update(address_params)
    else
      @order.addresses.billing.create(address_params)
    end
  end

  def save_address_shipping
    if @order.addresses.shipping.exists?
      @order.addresses.shipping.last.update(address_params)
    else
      @order.addresses.shipping.create(address_params)
    end
  end

  def address_params
    { 
      first_name: first_name,
      last_name: last_name,
      address: address,
      city: city,
      zip: zip,
      country: country,
      phone: phone,
      address_type: address_type
    }
  end
end 
