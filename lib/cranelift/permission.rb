# encoding: utf-8
module Cranelift

  # FIXME verificar a nescessidade de mover para um modelo ActiveRecord
  class Permission
    attr_accessor :name, :controller, :actions

    def initialize(args)
      @name       = args[:name] if args[:name]
      @controller = args[:controller] if args[:controller]
      @actions    = args[:actions] if args[:actions]
    end

    def self.defaults
      {
        gerente: [
          Permission.new(name: 'Gerenciar Projetos', controller: 'projetos', actions: 'all'),
          Permission.new(name: 'Gerenciar Usuários', controller: 'users', actions: 'all'),
          Permission.new(name: 'Gerenciar Ips', controller: 'ips', actions: 'all')
        ],
        comum: [
          Permission.new(name: 'Visualizer Projeto', controller: 'projetos', actions: 'show'),
          Permission.new(name: 'Visualizar Usuário', controller: 'users', actions: 'show')
        ]
      }
    end

    module ControllerAdditions
      def can?(action, controller)
        return false if current_user.role.nil?

        match = false
        current_user.role.permissions.each do |permission|
          puts permission.name + ', ' + permission.actions
          if permission.controller == controller and permission.actions.split.include?(action)
            match = true
            break
          end
        end
        return match
      end
    end

  end

end

if defined? ActionController
  ActionController::Base.class_eval do
    include Cranelift::Permission::ControllerAdditions
  end
end
