module Migrate
  class Base
    @@mysql = nil

    def mysql
      if @@mysql.nil?
        conf_yml = YAML::load_file(File.join(File.dirname(__FILE__), 'config.yml'))
        conf = c = OpenStruct.new(conf_yml)
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
