require 'red_carpet/access_control'

# require 'permissions/'
Dir["lib/permissions/*.rb"].each do |file|
  require file[4..-4]
end
