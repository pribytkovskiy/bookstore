module CommentsHelper
  def comments_has_error?(field)
    #@product.comment.errors.include?(field)
  end

  def comments_error_message(field)
    #@product.comment.errors.messages[field][0]
  end
end
