# encoding: utf-8
class Role < ActiveRecord::Base
  has_many :users

  attr_accessible :description, :name
  attr_accessor :permissions

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}

  def permissions
    return Permission::defaults[name]
  end

  def self.defaults
    gerente = Role.find_or_create_by_name('Gerente', :description => 'Gerencia o sistema')
    comum = Role.find_or_create_by_name('Usuário Comum', :description => 'Usuário comum do sistema')
    { gerente: gerente, comum: comum }
  end
end
