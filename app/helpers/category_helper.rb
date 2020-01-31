# app/helpers/category_helper.rb

module CategoryHelper
  def fetch_categories page, per
    categories =  $redis.get("categories")
    if categories.nil?
      @categories = Category.published.by_date.page(page).per(per)
      pagaination_param = {
          post_page: @post_page,
          post_per: @post_per
      }
      categories = Pagination.build_json(@categories, pagaination_param).to_json
      $redis.set("categories", categories)
      $redis.expire("categories", 1.hour.to_i)
    end
    categories
  end
end
