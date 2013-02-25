# encoding: utf-8
require 'cranelift'

class Repository < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_reader :scm
  attr_accessor :version

  def scm
    @scm ||= Cranelift::Scm.new(project_path, self.login, self.password)
    @scm
  end

  # Callbacks
  before_create do
    scm.checkout(url)
  end

  before_destroy do
    scm.delete_files
  end

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

  def revision
    scm.info.rev rescue '--'
  end

  def project_path
    @project_name ||= sanitize_string_to_folder_name(self.project.slug)
    @repository_name ||= sanitize_string_to_folder_name(self.name)

    REPOS_PATH.join(@project_name, @repository_name).to_s
  end

  def update_revision
    scm.update_repo(self.version.to_i) unless self.version.nil?
  end

  def update_directory_name
    true
  end

private
  def check_valid_repository
    errors.add(:url, 'URL especificada não é um repositório svn válido') if scm.svn.info(url).nil?
  end

  def sanitize_string_to_folder_name(s)
    s.downcase.gsub(/[\x00\/\\:\*\?\"<>\| ]/, '_')
  end
end
