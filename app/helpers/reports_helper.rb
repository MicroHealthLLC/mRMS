module ReportsHelper
  def render_pivot_information(document)
    @file = SpreadsheetEnumerationUpload.new(document)
    content  = @file.open_file
    if @file.extname == '.json'
      [[],JSON.parse(content),  nil]
    elsif @file.extname == '.xml'
      json =  Hash.from_xml(content)
      [[], json.map(&:last),  nil]
    elsif @file.extname == '.csv'
      [content[0], content[1]]
    else
      if content.class.in?([Roo::Excel])
        sheet = content.sheet(0)
        header = sheet.first
        tab = []
        sheet.each_with_index do |row, index|
          next if index.zero?
          json = {}
          header.each_with_index  do |title, i|
            json[title] = row[i].to_s.gsub(',', '').truncate(100)
          end
          tab << json
        end
        [header, tab, nil]
      elsif content.class.in?([Roo::Excelx])
        tab = []
        header = []
        content.each_row_streaming(pad_cells: true, max_rows: 0) do |row|
          header = row.map(&:value)
        end
        content.each_row_streaming(pad_cells: true, offset: 1) do |row|
          json = {}
          header.each_with_index  do |title, i|
            json[title] = row[i].value.to_s.gsub(',', '').truncate(100)
          end
          tab << json
        end
        [header, tab, nil]
      else
        @invalid_file_parse = "Error on parsing document"
      end
    end
  rescue CSV::MalformedCSVError => error
    @file.force_read_csv(document.path)
  rescue StandardError => error
    # Rollbar.critical("Read DOC: #{e.message}, file: #{file} ")
    @invalid_file_parse = "Error on parsing document"
  end

  def can_refresh_one_drive?(report)
    is_onedrive_dataset?(report) && current_user.onedrive_access_token.present?
  end

  def is_onedrive_dataset?(report)
    report.report_documents&.first&.onedrive_item_id&.present? rescue false
  end

  def filter_pivot_report
    enum_name = 'All'
    channel_enum_id = params[:channel_enum_id]
    if channel_enum_id
      enum_name = ChannelEnum.find_by_id(channel_enum_id).name
    end
    enum_name
  end

  def filter_report_dashbord
    enum_name = 'All'
    channel_enum_id = params[:channel_enum_id]
    if channel_enum_id
      enum_name = ChannelEnum.find_by_id(channel_enum_id).name
    end
    enum_name
  end

  def load_pivot_report(pivot_table_id)
    pivot_table = pivot_table_id ? update_pivot_table(pivot_table_id) : nil
    return pivot_table
  end

  def update_pivot_table(id)
    pivot_table = SavePivotTable.find_by_id(id)
    pivot_table.frequently_count += 1
    pivot_table.save
    return pivot_table
  end

  def default_report_enum
    channel_enum = 'All'
    channel_enum_id = params[:channel_enum_id]
    if channel_enum_id
      channel_enum = ChannelEnum.find_by_id(channel_enum_id).name
    end
    channel_enum
  end

  def default_dashboard_enum
    channel_enum = 'All'
    channel_enum_id = params[:channel_enum_id]
    if channel_enum_id
      channel_enum = ChannelEnum.find_by_id(channel_enum_id).name
    end
    channel_enum
  end

  def display_dashboard?
    @report.document_url && (@channel.is_group? && @channel.my_permission.can_manage_dashboard?) || @channel.is_public? || (@channel.is_personal? && @channel.is_creator?)
  end
end
