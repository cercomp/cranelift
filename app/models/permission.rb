# encoding: utf-8
class Permission < ActiveRecord::Base
  validates :name, :uniqueness => true

  def self.defaults
    {
      gerente: [
        Permission.find_or_create_by_name('Gerenciar Projetos', controller: 'projetos', actions: 'all'),
        Permission.find_or_create_by_name('Gerenciar Usuários', controller: 'users', actions: 'all'),
        Permission.find_or_create_by_name('Gerenciar Ips', controller: 'ips', actions: 'all')
      ],
      comum: [
        Permission.find_or_create_by_name('Visualizer Projeto', controller: 'projetos', actions: 'show'),
        Permission.find_or_create_by_name('Visualizar Usuário', controller: 'users', actions: 'show')
      ]
    }
  end
end
