module Migrate
  class Base
    @@mysql = nil
    @@config = nil
    @@log = nil

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

    def log
      if @@log.nil?
        @@log = File.open(Rails.root.join('log', 'phpmigration.log'), 'a+')
        @@log.puts "\n#{Time.new.to_s} ---------\n"
      end
      @@log
    end

    def debug_obj(obj)
      unless obj.valid?
        message = %{#{obj.class} : #{obj.inspect}\n#{obj.errors.full_messages}\n---\n}
        log.puts message
        puts message
      end
    end
  end
end
