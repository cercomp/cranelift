# encoding: utf-8
class Permission
  @@defaults = {
    'Gerente' => [
      { name: 'Gerenciar Projetos', controller: 'projects', actions: 'all' },
      { name: 'Gerenciar Usuários', controller: 'users', actions: 'all' },
      { name: 'Gerenciar Ips',      controller: 'ips', actions: 'all' }
    ],
    'Usuário Comum' => [
      { name: 'Visualizer Projeto', controller: 'projects', actions: 'show' },
      { name: 'Visualizar Usuário', controller: 'users', actions: 'show' }
    ]
  }
  def self.defaults
    @@defaults
  end
end
