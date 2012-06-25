require 'phpmigrate'

task :migrate => :environment do
  Migrate::RolesMigrate.new.migrate
  Migrate::UsersMigrate.new.migrate

  Migrate::IpsMigrate.new.migrate
end
