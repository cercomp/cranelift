# encoding: utf-8

def permissions
  {
    :gerente => [
      { name: 'Gerenciar Projetos', controller: 'projects', actions: 'all' },
      { name: 'Gerenciar Usuários', controller: 'users',    actions: 'all' },
      { name: 'Gerenciar Ips',      controller: 'ips',      actions: 'all' },
      { name: 'Ver Área Administrativa', controller: 'admin', actions: 'view' }
    ],
    :mantenedor => [
      { name: 'Visualizar Ips',     controller: 'ips',      actions: 'show' },
      { name: 'Visualizar Projeto', controller: 'projects', actions: 'show' },
      { name: 'Configurar Autoupdate', controller: 'projects', actions: 'show' },
      { name: 'Visualizar Usuário', controller: 'users',    actions: 'show' }
    ]
  }
end

gerente    = Role.find_or_create_by_name('Gerente', :description => 'Gerencia o sistema')
mantenedor = Role.find_or_create_by_name('Mantenedor',
                                         :description => 'Usuário mantenedor de projetos')

permissions[:gerente].each do |permission_h|
  gerente.permissions << Permission.create(permission_h)
end

permissions[:mantenedor].each do |permission_h|
  mantenedor.permissions << Permission.create(permission_h)
end
