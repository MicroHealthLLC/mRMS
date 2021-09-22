class ChannelEnum < Enumeration
  scope :default, -> {where(name: 'Uncategorized')}
  OptionName = :enumeration_channel_type

  def option_name
    OptionName
  end
end
