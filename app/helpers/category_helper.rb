# app/helpers/category_helper.rb

module CategoryHelper
  def fetch_categories
    categories =  $redis.get("categories")
    if categories.nil?
      categories = Category.all.to_json
      $redis.set("categories", categories)
      $redis.expire("categories",3.hour.to_i)
    end
    @categories = JSON.load categories
  end
end
