class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  validates :name,
            :presence => true,
            :length => {:in => 3..32}

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user and user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def status
    # Usando 5 minutos
    return (Time.now - self.last_action) < 5*60*60
  end

  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
