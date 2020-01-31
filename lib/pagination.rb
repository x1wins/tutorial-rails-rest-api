# /lib/pagination.rb
class Pagination
  def self.information array
    {
        current_page: array.current_page,
        next_page: array.next_page,
        prev_page: array.prev_page,
        total_pages: array.total_pages,
        total_count: array.total_count
    }
  end
  def self.build_json array, pagaination_param = {}
    ob_name = array.name.downcase.pluralize.to_sym
    json = Hash.new
    json[ob_name] = ActiveModelSerializers::SerializableResource.new(array.to_a, pagaination_param: pagaination_param)
    pagination_name = "#{ob_name}_pagination".to_sym
    json[pagination_name] = self.information array
    json
  end
end