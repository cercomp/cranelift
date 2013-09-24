require 'bcrypt'

class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many :logs
  belongs_to :role

  attr_accessor :password
  before_save :encrypt_password
  
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  validates :login,
            :presence => true,
            :uniqueness => true,
            :length => { :in => 2..32 }

  validates :first_name,
            :presence => true,
            :length => {:in => 3..32}

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  # TODO fazer login com LDAP http://rubygems.org/gems/net-ldap
  # http://redmine.rubyforge.org/svn/trunk/app/models/auth_source_ldap.rb
  def self.authenticate(login, password)
    user = find_by_login(login)
    if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def status
    (Time.now - self.last_action) < 5*60*60
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def name=(name)
    names = name.split
    self.first_name = names.shift
    self.last_name = names.join(' ')
  end

  def name
    [self.first_name, self.last_name].join(' ')
  end

  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
