#!/bin/bash

# Description: initializes repo with required Gemfile, secret_token.rb, rspec
# directory (spec), spec_helper.rb, and initializes guard with the required 
# Guardfile 
case $1 in
   "")
      echo "Usage: railsNew.sh [repo name]"
      echo -n "Note: repo name's first letter should be UPPERCASE or else"
      echo " rspec installation will fail"
      ;;
   *)
      cd ..
      rails new $1 --skip-test-unit

      cp CreateRailsRepo/gemfileBackup $1/Gemfile
      cp CreateRailsRepo/secretTokenBackup.rb\
       $1/config/initializers/secret_token.rb

      echo -e "\n$1::Application.config.secret_key_base = secure_token"\
       >> $1/config/initializers/secret_token.rb 
      cd $1
      bundle update
      bundle install --without production

      rails generate rspec:install
      cp ../CreateRailsRepo/specHelperBackup.rb spec/spec_helper.rb

      guard init rspec
      spork --bootstrap
      echo "--drb" >> .rspec
      guard init spork
      cp ../CreateRailsRepo/guardfileBackup Guardfile

      filesize=$(stat -c %s config/application.rb)
      truncateSize=$(($filesize - 10))
      truncate -s $truncateSize config/application.rb      
      echo '  config.assets.precompile += %w(*png *.jpg *.jpeg *.gif)'\
       >> config/application.rb
      echo '  end' >> config/application.rb
      echo 'end' >> config/application.rb

      rails generate controller StaticPages home help about contacts\
       --no-test-framework
      cd ../CreateRailsRepo
      cp custom.css.scss ../$1/app/assets/stylesheets/custom.css.scss
      cp about.html.erb contacts.html.erb help.html.erb home.html.erb\
       ../$1/app/views/static_pages
      cp application.html.erb ../$1/app/views/layouts
      cp application_helper.rb ../$1/app/helpers
      cp *.jpg ../$1/app/assets/images
      cd ../$1
      rails generate integration_test StaticPages
      cd ../CreateRailsRepo
      cp static_pages_spec.rb ../$1/spec/requests
      ;;
esac
