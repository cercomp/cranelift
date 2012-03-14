class Project < ActiveRecord::Base
  has_many :repositories
  has_many :project_users
  has_many :users, :through => :project_users

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}
end
