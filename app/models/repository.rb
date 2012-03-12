class Repository < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :project

  validates :url,
            :presence => :true

  validates :autoupdate_login,
            :presence => true,
            :if => "!enable_autoupdate.nil?"

  validates :autoupdate_password,
            :presence => true,
            :if => "!enable_autoupdate.nil?"

  # TODO usar uma classe abstrata para decidir qual scm usar
  class Scm
    def initialize(proj)
      @project = proj
    end

    def checkout
      svn.checkout(proj.url, @project.project_path)
    end

    def update (rev)
      svn.update(@project.project_path, rev)
    end

    def log (start = 0, limit = 0)
      svn.log(@project.project_path, start, 'HEAD', limit)
    end

    def svn
      @svn ||= CraneLift::SvnScm.new
    end
  end

  def scm
    return Scm.new(self)
  end

  def project_path
    File.join(Rails.root, 'projects', self.name)
  end
end
