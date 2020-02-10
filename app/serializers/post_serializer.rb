class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :body, :files, :comments_pagination
  has_one :user
  has_many :comments
  def files
    return unless object.files.attachments
    file_urls = object.files.map do |file|
      rails_blob_url(file)
    end
    file_urls
  end
  def comments
    comment_page = (instance_options.dig(:pagaination_param, :comment_page).presence || 1).to_i
    comment_per = (instance_options.dig(:pagaination_param, :comment_per).presence || 10).to_i
    object.comments.published.by_date.page(comment_page).per(comment_per)
  end
  def comments_pagination
    comment_per = (instance_options.dig(:pagaination_param, :comment_per).presence || 10).to_i
    Pagination.build_json(comments)[:comments_pagination] if comment_per > 0
  end
end
