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

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :zip, presence: true
  validates :first_name, :last_name, :address, :city, :country, length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country, format: { with: ONLY_LETTERS, message: I18n.t('only_letters') }
  validates :zip, length: { maximum: 5 }, format: { with: ONLY_NUMBERS, message: I18n.t('only_numbers') }
  validates :phone, length: { maximum: 15 }, format: { with: STARTS_WITH_PLUS, message: I18n.t('starts_with_plus') }

  attr_reader :billing_address, :shipping_address

  def initialize(context)
    @order = Order.find_by(id: context.id)
  end

  def save
    return false unless valid?

    persist!
    true
  end

  private

  def persist!
    save_billing & save_shipping
  end

  def save_shipping
    if @order.addresses.shipping.exists?
      @order.addresses.shipping.last.update(address_params(set_address_params_type_for_shipping_address))
    else
      @order.addresses.shipping.create(address_params(set_address_params_type_for_shipping_address))
    end
  end

  def save_billing
    if @order.addresses.billing.exists?
      @order.addresses.billing.last.update(address_params(:billing))
    else
      @order.addresses.billing.create(address_params(:billing))
    end
  end

  def set_address_params_type_for_shipping_address
    return :billing if check == 'true'

    :shipping
  end

  def address_params(type)
    params.require(type).permit(:firstname, :lastname, :address, :city, :zip, :country, :phone)
  end
end 
