class SortProducts
  include Interactor
  NAME_DEFAULT_PARAM_SORT = 'Newest first'

  def call
    context.name_sort = context.params[:name_sort] ? context.params[:name_sort] : NAME_DEFAULT_PARAM_SORT
    context.products = Product.sort_product(context)
  end
end
