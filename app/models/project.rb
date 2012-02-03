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
end
