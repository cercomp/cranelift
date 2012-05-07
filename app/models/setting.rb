class Setting < ActiveRecord::Base
  validates :name, :uniqueness => true

  @@default_settings = YAML::load(File.open("#{Rails.root}/config/default_settings.yml"))

  def self.find_or_default(name)
    Setting.find_or_create_by_name(name.to_s, :value => @@default_settings[name.to_s])
  end
end
