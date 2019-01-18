module Support
  module Select2Helper
    def select2(value, attrs)
      find("#select2-#{attrs[:from]}-container").click
  
      list = find(:xpath, '//span[@class="select2-results"]', visible: :all)
      list.find("li", text: value).click
    end
  end
end