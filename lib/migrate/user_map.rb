module Migrate
  # hash para recuperar os ids antigos/novos da migracao
  class UserMap
    # map dos ids novos para os antigos
    @@map = {}

    def self.old_id(new)
      @@map[new.to_i]
    end

    def self.new_id(old)
      @@map.invert[old.to_i]
    end

    def self.store(new, old)
      @@map[new.to_i] = old.to_i
    end

    def self.dump
      puts @@map.to_s
    end
  end
end
