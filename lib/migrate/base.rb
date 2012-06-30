module Migrate
  class Base
    @@mysql = nil
    @@config = nil

    def config
      if @@config.nil?
        conf_yml = YAML::load_file(File.join(File.dirname(__FILE__), 'config.yml'))
        @@config = OpenStruct.new(conf_yml)
      end
      @@config
    end

    def mysql
      if @@mysql.nil?
        c = self::config
        @@mysql = Mysql2::Client.new(
          :host     => c.host,
          :username => c.user,
          :password => c.pass,
          :database => c.name
        )
      end

      @@mysql
    end

    def debug_obj(obj)
      puts %{#{obj.inspect}\n#{obj.errors.full_messages}\n---\n} unless obj.valid?
    end
  end
end
