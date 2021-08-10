class ReportEnum < Enumeration
  scope :default, -> { where(name: 'Default') }
  OptionName = :enumeration_report_type

  def option_name
    OptionName
  end
end
