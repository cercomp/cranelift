# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

flag = User.create(
  id: 1,
  login: 'admin',
  password: 'admin',
  password_confirmation: 'admin',
  admin: 'true',
  name: 'Administrador',
  email: 'admin@admin.com',
  active: 'true',
  login_type: 'normal',
  role_id: 1
)
puts flag ? 'Administrador criado com sucesso' : 'Não foi possível cadastrar o administrador'

Role::defaults # Cria os papeis padrão
