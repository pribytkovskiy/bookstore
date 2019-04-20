class OrderItem::DestroyOrderItem
  include Interactor

  def call
    current_item = OrderItem.find_by(id: context.id)
    return context.fail!(message: I18n.t('interactors.errors.current_item_failure')) unless current_item

    current_item.destroy
  end
end
