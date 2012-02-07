class Project < ActiveRecord::Base
  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}

  validates :url,
            :presence => :true

  validates :autoupdate_login,
            :presence => true,
            :if => "!enable_autoupdate.nil?"

  validates :autoupdate_password,
            :presence => true,
            :if => "!enable_autoupdate.nil?"

  # TODO usar uma classe abstrata para decidir qual scm usar
  def checkout
    svn.checkout(self.url, project_path)
  end

  def update (rev)
    svn.update(project_path, rev)
  end

  def log (start = 0, limit = 0)
    svn.log(project_path, start, 'HEAD', limit)
  end

  private
  def project_path
    File.join(Rails.root, 'projects', self.name)
  end

  def svn
    @svn ||= CraneLift::SvnScm.new
  end
end
