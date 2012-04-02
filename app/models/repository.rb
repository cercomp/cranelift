class Repository < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :project

  validates :name,
    :presence => true,
    :uniqueness => { :scope => :project_id },
    :length => {:in => 3..32}

  validates :url,
    :presence => :true,
    :format => { :with => /^http[s]{,1}:\/\/[\w\.\-\%\#\=\?\&]+\.([\w\.\-\%\#\=\?\&]+\/{,1})*/i }

  validates :autoupdate_login,
    :presence => true,
    :if => "enable_autoupdate == true"

  validates :autoupdate_password,
    :presence => true,
    :if => "enable_autoupdate == true"

  # TODO usar uma classe abstrata para decidir qual scm usar
  class Scm
    def initialize(proj)
      @project = proj
    end

    def checkout
      svn.checkout(@project.url, @project.project_path)
    end

    def update (rev)
      svn.update(@project.project_path, rev)
    end

    def log (start = 0, limit = 0)
      svn.log(@project.project_path, start, 'HEAD', limit)
    end

    def delete_files
      if File.directory?(@project.project_path)
        FileUtils.rm_rf(@project.project_path)
      end
    end

    def svn
      @svn ||= ::Cranelift::SvnScm.new
    end
  end

  def scm
    return Scm.new(self)
  end

  def project_path
    File.join(Rails.root, 'repositories', self.project.name, self.name)
  end
end
