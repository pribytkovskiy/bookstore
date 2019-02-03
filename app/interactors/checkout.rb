class Checkout
  include Interactor::Organizer

  organize AddressOrder, DeliveryOrder, PaymentOrder, ConfirmationOrder
end
