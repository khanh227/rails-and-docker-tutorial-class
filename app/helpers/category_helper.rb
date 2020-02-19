module CategoryHelper
  def category_list
    Category.enabled.pluck(:name, :id)
  end
end
