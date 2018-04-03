module MailerHelper
  def email_template(&block)
    content_for :page_content, &block
    render partial: 'user_mailer/template'
  end

  def format_date_time(datetime)
    datetime.strftime("#{Setting['format_date']} %I:%M %p") if datetime
  end

end
