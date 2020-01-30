# /lib/pagination.rb
class Pagination
  def self.build_json object, pagaination_param = {}
    ob_name = object.name.downcase.pluralize.to_sym
    json = Hash.new
    json[ob_name] = ActiveModelSerializers::SerializableResource.new(object.to_a, pagaination_param: pagaination_param)
    pagination_name = "#{ob_name}_pagination".to_sym
    json[pagination_name] = {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
    }
    return json
  end
end