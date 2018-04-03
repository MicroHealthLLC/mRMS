class EmailTemplate < ApplicationRecord
  def self.available_models
    models -  EmailTemplate.pluck(:model)
  end

  def self.default(body = nil)
    new(
        header: "Hello %{user_name},",
        body: body,
        footer: 'Thanks and have a good day'
    )
  end

  def self.models
    ApplicationRecord.subclasses.select{|klass| klass.new.can_send_email?}.map(&:to_s)
  end
end
