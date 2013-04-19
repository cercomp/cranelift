require 'rake/dsl_definition'
require 'phpmigrate'

namespace :cranelift do
  desc "Migrate all database from old php version"
  task :migrate => :environment do
    Migrate::Users.new.migrate
    Migrate::Ips.new.migrate
    Migrate::Projects.new.migrate
  end

  desc "Create fake php projects folders - to dev"
  task :create_fake_projects_folders => :environment do
    Migrate::ProjectsMigrate.new.create_fake_folders
  end
end
