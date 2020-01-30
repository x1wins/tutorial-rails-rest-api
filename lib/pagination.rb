# /lib/pagination.rb
class Pagination
  def self.build_json object, pagaination_param = {}
    ob_name = object.name.downcase.pluralize
    json = Hash.new
    json[ob_name] = ActiveModelSerializers::SerializableResource.new(object.to_a, pagaination_param: pagaination_param)
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