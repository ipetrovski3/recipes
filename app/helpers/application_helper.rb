module ApplicationHelper
  def title
    if content_for?(:title)
      content_for :title
    else
      'Food Recipes'
    end
  end
end
