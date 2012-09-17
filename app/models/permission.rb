# encoding: utf-8
class Permission
  @@defaults = {
    'Gerente' => [
      { name: 'Gerenciar Projetos', controller: 'projects', actions: 'all' },
      { name: 'Gerenciar Usuários', controller: 'users',    actions: 'all' },
      { name: 'Gerenciar Ips',      controller: 'ips',      actions: 'all' }
    ],
    'mantenedor' => [
      { name: 'Visualizar Ips',     controller: 'ips',      actions: 'show' },
      { name: 'Visualizar Projeto', controller: 'projects', actions: 'show' },
      { name: 'Configurar Autoupdate', controller: 'projects', actions: 'show' },
      { name: 'Visualizar Usuário', controller: 'users',    actions: 'show' }
    ]
  }

  def self.defaults
    @@defaults
  end
end
