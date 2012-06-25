module Migrate
  class IpsMigrate < Migrate::Base
    def migrate
      puts "Migrando ips..."

      regs = mysql.query('select * from ips')
      regs.each do |reg|
        obj = ::Ip.create :ip => reg['ip'],
          :cidr        => reg['cidr'],
          :description => reg['desc']

        debug_obj(obj)
      end
    end
  end
end
