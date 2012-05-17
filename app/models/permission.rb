# encoding: utf-8
class Permission
  @@defaults = {
      gerente: [
        { name: 'Gerenciar Projetos', controller: 'projects', actions: 'all' },
        { name: 'Gerenciar Usuários', controller: 'users', actions: 'all' },
        { name: 'Gerenciar Ips', controller: 'ips', actions: 'all' }
      ],
      comum: [
        { name: 'Visualizer Projeto', controller: 'projects', actions: 'show' },
        { name: 'Visualizar Usuário', controller: 'users', actions: 'show' }
      ]
    }
  end
end
