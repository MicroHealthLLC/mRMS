class DashboardEnum < Enumeration
  scope :default, -> { where(name: 'Default') }
  OptionName = :enumeration_dashboard_type

  def option_name
    OptionName
  end
end
