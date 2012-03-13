class Project < ActiveRecord::Base
  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}

  has_many :repositories
end
