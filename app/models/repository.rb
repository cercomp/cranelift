# encoding: utf-8

class Repository < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_reader :scm
  attr_accessor :version

  # Callbacks
  before_create :checkout
  before_destroy :destroy_files
  before_update :update_revision

  # Relatioships
  belongs_to :project

  # Validations
  validates_presence_of :project

  validates :name,
    :presence => true,
    :uniqueness => { :scope => :project_id },
    :format => { :with => /\A[\w\s]+\z/, :message => 'É permitido apenas letras e números no nome' },
    :length => {:in => 3..32}

  validates :url, :presence => :true
  validates :password, :presence => true, :if => "!login.blank?"
  validate :check_valid_repository, :on => :create

  def scm
    @scm ||= Cranelift::Scm.new(path, self.login, self.password)
  end

  def revision
    scm.info.rev rescue '--'
  end

  def path
    REPOS_PATH.join(project.slug, slug).to_s
  end

  def update_revision
    scm.update_repo(self.version.to_i) unless self.version.nil?
  end

  def check_valid_repository
    errors.add(:url, 'URL especificada não é um repositório svn válido') if scm.svn.info(url).nil?
  end
  private :check_valid_repository

  def checkout
    scm.checkout(url)
  end
  private :checkout

  def destroy_files
    scm.delete_files
  end
  private :destroy_files
end
