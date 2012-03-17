class Role < ActiveRecord::Base
  has_many :project_users
  has_many :users,    :through => :project_users
  has_many :projects, :through => :project_users

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}
end
