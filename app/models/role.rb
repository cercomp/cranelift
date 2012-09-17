# encoding: utf-8
class Role < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :permissions

  attr_accessible :description, :name

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}
end
