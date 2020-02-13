# app/helpers/category_helper.rb

module CategoryHelper
  def fetch_categories pagaination_param
    page = pagaination_param[:category_page]
    per = pagaination_param[:category_per]
    key = "categories"+pagaination_param.to_s
    categories =  $redis.get(key)
    if categories.nil?
      @categories = Category.published.by_date.page(page).per(per)
      categories = Pagination.build_json(@categories, pagaination_param).to_json
      $redis.set(key, categories)
      $redis.expire(key, 1.hour.to_i)
    end
    categories
  end
  def clear_cache_categories
    keys = $redis.keys "*categories*"
    keys.each {|key| $redis.del key}
  end
end
