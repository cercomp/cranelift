class Migrate::ProjectsMigrate < Migrate::Base
  def migrate
    puts "Migrando projetos..."

    # regs.each do |reg|
    #   obj = ::Ip.create :ip => reg['ip'],
    #     :cidr        => reg['cidr'],
    #     :description => reg['desc']

    #   debug_obj(obj)
    # end
  end

  def create_fake_folders
    puts "Migrando projetos..."

    regs = mysql.query('select * from projetos')
    regs.each do |r|
      name = r['alias']
      Dir.mkdir Rails.root.join('repositories', name)
      Dir.mkdir Rails.root.join('repositories', name, name  )
    end
  end

end
