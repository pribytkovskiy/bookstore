module ActiveAdminHelpers
  def self.included(dsl); end

  def collected_authors(form_builder)
    Author.all.map do |author|
      ["#{author.first_name} #{author.last_name}",
       author.id,
       { checked: form_builder.object.authors.include?(author.id.to_s) }]
    end
  end

  def category_all
    Category.all.map { |category| [category.category, category.id] }
  end
end
