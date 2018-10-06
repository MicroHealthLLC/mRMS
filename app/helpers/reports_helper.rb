module ReportsHelper
  def render_pivot_information(document)
    @file = SpreadsheetEnumerationUpload.new(document)
    content  = @file.open_file
    if @file.extname == '.json'
      [[],JSON.parse(content),  nil]
    elsif @file.extname == '.xml'
      json =  Hash.from_xml(content)

      [[], json.map(&:last),  nil]
    else
      if content.class.in?([Roo::CSV, Roo::Excelx, Roo::Excel])
        sheet = content.sheet(0)
        header = sheet.first
        tab = []
        sheet.each_with_index do |row, index|
          next if index.zero?
          json = {}
          header.each_with_index  do |title, i|
            json[title] = row[i].to_s.gsub(',', '')
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
    Rollbar.critical("Read DOC: #{e.message}, file: #{file} ")
    @invalid_file_parse = "Error on parsing document"
  end
end
