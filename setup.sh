git pull
bundle install
rails db:migrate  RAILS_ENV=production
RAILS_ENV=production bin/rails assets:precompile
