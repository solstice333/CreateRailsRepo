#CreateRailsRepo#

##Decription##
Automates the creation of a Rails repository with specific settings relating to the Gemfile, Guardfile, secret_token.rb, and spec_helper.rb. Sets up rspec, guard, and spork. Automates application.rb in config to include configuration for the assets pipeline for bootstrap-sass compatibility. Stops right before any database manipulations are made which completes the setup of the repo.

##How to Use##
In terminal,

```
$ git clone https://github.com/solstice333/CreateRailsRepo.git
$ cd CreateRailsRepo 
$ ./railsNew.sh [ name of repo starting with an uppercase character e.g. Foo ]
$ cd ..  #Rails repo should now be in the directory above
```
