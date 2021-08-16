def create_channel
  return @user.channels.create(name: 'New Created', is_public: true, description: 'description',is_active: true,option: 3,icon: "fab fa-500px")
end
