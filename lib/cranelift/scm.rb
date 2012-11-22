module Cranelift
  class Scm
    attr_accessor :project_path, :login, :password

    @@svn = nil

    def initialize(project_path, login = nil, password = nil)
      self.project_path = project_path
      self.login = login
      self.password = password
    end
    
    def update
    end

    def checkout(url)
      # Só faz o checkout caso o diretório não exista
      unless File.directory?(project_path)
        svn.checkout(url, project_path)
      end
    end

    def update_repo (rev)
      svn.update(project_path, rev)
    end

    def log (start = 0, limit = 0)
      svn.log(project_path, start, 'HEAD', limit)
    end

    def delete_files
      if File.directory?(project_path)
        FileUtils.rm_rf(project_path)
      end
    end

    def info
      svn.info(project_path)
    end

    def svn
      if @svn.nil?
        @svn = ::Cranelift::Scm::Adapters::Subversion.new
        @svn.ctx.add_simple_prompt_provider(0) do |cred, realm, username, may_save|
          cred.username = login
          cred.password = password
          cred.may_save = false
        end
      end
      @svn
    end
  end
end
