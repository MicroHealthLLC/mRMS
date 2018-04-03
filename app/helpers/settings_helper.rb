module SettingsHelper

  # Returns the options for the date_format setting
  def date_format_setting_options(locale)
    Setting::DATE_FORMATS.map do |f|
      today = ::I18n.l(Date.today, :locale => locale, :format => f)
      format = f.gsub('%', '').gsub(/[dmY]/) do
        {'d' => 'dd', 'm' => 'mm', 'Y' => 'yyyy'}[$&]
      end
      ["#{today} (#{format})", f]
    end
  end

end
