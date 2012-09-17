namespace :cranelift do
  # FIXME losing user roles
  desc 'Reset system permissions and roles'
  task :reset_permissions_roles => :environment do
    Role.destroy_all
    Permission.destroy_all
    require Rails.root.join('db', 'seeds', 'permissions_roles.rb')
  end
end
