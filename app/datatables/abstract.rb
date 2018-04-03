class Abstract < AjaxDatatablesRails::Base
  def aggregate_query
    conditions = searchable_columns.each_with_index.map do |column, index|
      value = params[:columns]["#{index}"][:search][:value] if params[:columns] rescue nil
      search_condition(column, value) unless value.blank?
    end
    conditions.compact.reduce(:and)
  end
end
