class Abstract < AjaxDatatablesRails::Base
  def aggregate_query
    conditions = searchable_columns.each_with_index.map do |column, index|
      value = params[:columns]["#{index}"][:search][:value] if params[:columns] rescue nil
      search_condition(column, value) unless value.blank?
    end
    conditions.compact.reduce(:and)
  end

  def sort_records(records)
    sort_by = []
    params[:order].values.each do |item|
      sort_by << "#{sort_column(item)} #{sort_direction(item)}"
    end
    records.order(sort_by.join(", "))
  end

  def generate_sortable_displayed_columns
    @sortable_displayed_columns = []
    params[:columns].values.each do |column|
      @sortable_displayed_columns << column[:data] if column[:orderable] == 'true'
    end
    @sortable_displayed_columns
  end

end
