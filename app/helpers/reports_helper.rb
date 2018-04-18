module ReportsHelper
  def render_pivot_information(document)
    @file = SpreadsheetEnumerationUpload.new(document)
    roo_csv  = @file.open_file
    sheet = roo_csv.sheet(0)
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
    [header, tab]
  end
end
