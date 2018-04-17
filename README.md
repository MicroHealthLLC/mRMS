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

`rails s`
or run it in the background rails s -e production > /dev/null &


