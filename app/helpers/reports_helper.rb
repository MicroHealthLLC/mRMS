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
      sheet = content.sheet(0)
      header = sheet.first
      tab = []
      sheet.each_with_index do |row, index|
        next if index.zero?
        json = {}
        header.each_with_index  do |title, i|
          json[title] = row[i]
        end
        tab << json
      end
      [header, tab, nil]
    end
  rescue CSV::MalformedCSVError => error
    @file.force_read_csv(document.path)
  end
end
