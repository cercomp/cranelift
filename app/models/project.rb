class Project < ActiveRecord::Base
  has_many :repositories, :dependent => :destroy
  has_and_belongs_to_many :users

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}
end
