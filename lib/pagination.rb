# my_app/app/serializers/pagination_serializer.rb
class Pagination
  def self.build object
    meta = {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
    }
    return meta
  end
end