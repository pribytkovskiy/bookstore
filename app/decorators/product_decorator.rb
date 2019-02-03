class ProductDecorator < Draper::Decorator
  delegate_all

  def price
    "€#{object.price}"
  end

  def date
    object.year.strftime("%Y")
  end

  def author_name
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end 

  def image
    object.covers.first.image_url
  end

  def avatar
    object.comment.user.pictures
  end

  def comment_date
    object.comment.updated_at.strftime("%B %d, %Y")
  end

end
