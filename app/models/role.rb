# encoding: utf-8
# FIXME mover defaults para um outro arquivo
class Role < ActiveRecord::Base
  has_many :users

  attr_accessor :permissions

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}

  def self.defaults
    gerente = Role.new :name => 'Gerente', :description => 'Gerencia o sistema'
    gerente.permissions = Cranelift::Permission.defaults[:gerente]

    comum = Role.new :name => 'Usuário Comum', :description => 'Usuário comum do sistema'
    comum.permissions = Cranelift::Permission.defaults[:comum]
    
    {gerente: gerente, comum: comum}
  end
end
