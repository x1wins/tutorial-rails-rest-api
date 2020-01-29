# /lib/pagination.rb
class Pagination
  def self.build_json object, nested_page = 1, nested_per = 10
    ob_name = object.name.downcase
    json = Hash.new
    json[ob_name] = ActiveModel::SerializableResource.new(object.to_a, nested_page: nested_page, nested_per: nested_per)
    json[:pagination] = {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
    }
    return json
  end
end