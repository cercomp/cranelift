# NOTE Papeis não serão migrados do projeto antigo

module Migrate
  class Roles < Migrate::Base
    def migrate
      puts "Migrando papeis..."

      regs = mysql.query('select * from role')
      regs.each do |reg|
        obj = ::Role.find_or_create_by_name(
          reg['name'],
          :description => reg['description']
        )
        debug_obj(obj)
      end
    end
  end
end
