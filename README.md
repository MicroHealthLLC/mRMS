# mRMS
MicroHealth Reports Made Simple

# Installation:

This project use Ruby 2.3+ and rails 5.0 and Mysql 

Install ImageMagick

Install Redis

`Bundle install`

create mysql database simple_report

go to config directory and edit database.yml to connect to mysql

'rails generate simple_form:install'

`rake db:migrate`

and you should create an admin user 

`rake db:seed`

Running the server

start your app rails s -e production -b localhost -d 
or 
rails s -e production > /dev/null &

start sidekiq bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production


