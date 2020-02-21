class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :body, :category, :files, :comments_pagination
  has_one :user
  has_many :comments
  def category
    {
        id: object.category.id,
        title: object.category.title,
        body: object.category.body
    }
  end
  def files
    return unless object.files.attachments
    file_urls = object.files.map do |file|
      {
          id: file.id,
          url: rails_blob_url(file)
      }
    end
    file_urls
  end
  def comments
    comment_page = (instance_options.dig(:pagaination_param, :comment_page).presence || 1).to_i
    comment_per = (instance_options.dig(:pagaination_param, :comment_per).presence || Pagination.per).to_i
    object.comments.published.by_date.page(comment_page).per(comment_per)
  end
  def comments_pagination
    comment_per = (instance_options.dig(:pagaination_param, :comment_per).presence || Pagination.per).to_i
    Pagination.build_json(comments)[:comments_pagination] if comment_per > 0
  end
end
