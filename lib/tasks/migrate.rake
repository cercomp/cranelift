require 'rake/dsl_definition'
require 'phpmigrate'

namespace :cranelift do
  desc "Migrate all database from old php version"
  task :migrate => :environment do
    Migrate::Users.new.migrate
    Migrate::Ips.new.migrate
    Migrate::Projects.new.migrate
  end

  task :migrate_single_project, [:project_id] => :environment do |t, args|
    args.with_defaults(:project_id => false)
    unless(args.project_id)
      "You need to specify a project id, e.g.: rake migrate_single_project[10]"
    end

    Migrate::Users.new.migrate
    Migrate::Ips.new.migrate
    Migrate::Projects.new.migrate(args.project_id)
  end

  desc "Create fake php projects folders - to dev"
  task :create_fake_projects_folders => :environment do
    Migrate::ProjectsMigrate.new.create_fake_folders
  end
end
