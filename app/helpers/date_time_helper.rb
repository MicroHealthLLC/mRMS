module DateTimeHelper

  def format_date datetime
    if datetime.present?
      datetime.to_date.strftime(Setting['format_date']) rescue ''
    end
  end

  def format_date_time(datetime)
    datetime.strftime("#{Setting['format_date']} %I:%M %p") if datetime
  end
end