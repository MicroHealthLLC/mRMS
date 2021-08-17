def create_channel
  return @user.channels.create(name: 'New Created', is_public: true, description: 'description',is_active: true,option: 3,icon: "fab fa-500px")
end

def create_report(channel)
  return channel.reports.create(name: "Lorem Ipsum 234",user_id: @user.id,description:"<p>New reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew reportNew report</p>\r\n")
end
