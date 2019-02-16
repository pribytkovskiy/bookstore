class OrderItem::DestroyOrderItem
  include Interactor

  def call
    context.fail!(message: I18n.t('interactors.errors.current_item_failure')) unless current_item = OrderItem.find(context.id)
    current_item.destroy
  end
end
