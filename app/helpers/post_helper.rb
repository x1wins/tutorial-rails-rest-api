# app/helpers/post_helper.rb

module PostHelper
  def fetch_posts pagaination_param
    category_id = pagaination_param[:category_id]
    search = pagaination_param[:search]
    page = pagaination_param[:post_page]
    per = pagaination_param[:post_per]
    key = "posts"+pagaination_param.to_s
    posts =  $redis.get(key)
    if posts.nil?
      @posts = Post.category(category_id).search(search).published.by_date.page(page).per(per)
      posts = Pagination.build_json(@posts, pagaination_param).to_json
      $redis.set(key, posts)
      $redis.expire(key, 1.hour.to_i)
    end
    posts
  end
  def clear_cache_posts
    keys = $redis.keys "*posts*"
    keys.each {|key| $redis.del key}
  end
end
