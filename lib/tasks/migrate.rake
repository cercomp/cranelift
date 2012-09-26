require 'rake/dsl_definition'
require 'phpmigrate'

namespace :cranelift do
  namespace :migrate do
    include Rake::DSL

    migrate_models = [:users, :ips, :projects]

    migrate_models.each do |model|
      class_eval <<-BLOCK
        task :#{model} => :environment do
          Migrate::#{(model.to_s + '_migrate').classify}.new.migrate
        end
      BLOCK
    end

    desc "Migrate all database from old php version"
    task :all => :environment do
      migrate_models.each do |model|
        eval "Migrate::#{(model.to_s + '_migrate').classify}.new.migrate"
      end
    end
  end

  desc "Create fake php projects folders - to dev"
  task :create_fake_projects_folders => :environment do
    Migrate::ProjectsMigrate.new.create_fake_folders
  end
end
