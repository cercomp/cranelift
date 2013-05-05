module Migrate
  class FakeRepository < ::ActiveRecord::Base
    self.table_name = 'repositories'
  end

  class Projects < Migrate::Base
    def migrate
      puts "Migrando projetos..."

      phpsvn_projects.each do |reg|
        copy_repository_from_php(reg['alias'])

        pj = ::Project.create(name: reg['alias'])
        debug_obj(pj)

        repo = FakeRepository.create(name: reg['alias'],
                                     url: reg['nome'],
                                     enable_autoupdate: reg['autoupdate'],
                                     login: reg['co_login'],
                                     password: reg['co_password'],
                                     project_id: pj.id)

        add_users_to_project(pj, reg['id'])
      end
    end

    def phpsvn_projects
      mysql.query('select * from projetos')
    end

    def add_users_to_project(cr_project, old_project_id)
      regs = mysql.query("select * from user_projetos
                         where id_projetos = #{old_project_id}")

      users_ids = regs.map{ |reg| ::Migrate::UserMap.new_id(reg['id_user']) }
      debugger if users_ids.include?(0)
      cr_project.users = ::User.find(users_ids) if users_ids.any?
    end

    def copy_repository_from_php(repository)
      origin = File.join(config.php_projects_path, repository)
      destiny = Rails.root.join('repositories', repository)

      FileUtils.mkdir destiny
      FileUtils.cp_r Dir[origin], File.join(destiny, ''), :verbose => true
    end

    def create_fake_folders
      puts "Criando pastas fakes para desenvolvimento..."

      regs = mysql.query('select * from projetos')
      regs.each do |r|
        name = r['alias']
        FileUtils.mkpath File.join(config.php_projects_path, name, name)
      end
    end
  end
end
