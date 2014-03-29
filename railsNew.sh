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
      ;;
esac
