source 'https://rubygems.org'
ruby '2.2.0'

# Standard Rails gems
gem 'rails', '4.2.0'
gem 'sass-rails', '5.0.0'
gem 'uglifier', '2.6.0'
gem 'coffee-rails', '4.1.0'
gem 'jquery-rails', '4.0.2'
gem 'turbolinks', '2.5.3'
gem 'jbuilder', '2.2.6'
gem 'bcrypt', '3.1.9'
gem 'httparty', '0.13.3'
gem 'encrypto_signo'
gem 'openssl'
gem "paperclip", "~> 4.2"
gem 'bcrypt-ruby', '~> 3.0.0'

# Necessary for Windows OS (won't install on *nix systems)
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# Kaminari: https://github.com/amatsuda/kaminari
gem 'kaminari', '0.16.1'

# Friendly_id: https://github.com/norman/friendly_id
gem 'friendly_id', '5.0.4'

# Font-awesome: https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '4.2.2'

# Bootstrap 3: https://github.com/twbs/bootstrap-sass
gem 'bootstrap-sass', '3.3.1.0'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'awesome_print'

  # Figaro: https://github.com/laserlemon/figaro
  gem 'figaro', '1.0.0'
  
  # Spring: https://github.com/rails/spring
  gem 'spring', '1.2.0'
end

# SQLite 3
group :development, :test do
  gem 'sqlite3', '1.3.10'
end

# Devise: https://github.com/plataformatec/devise
gem 'devise', '3.4.1'

group :production do
  gem 'rails_12factor' # Rails 12factor for Heroku: https://github.com/heroku/rails_12factor
  gem 'pg'# PostgreSQL gem for Heroku
  gem 'unicorn', platforms: [:ruby] # Unicorn: http://unicorn.bogomips.org
end
