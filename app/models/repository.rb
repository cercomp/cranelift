# encoding: utf-8
require 'cranelift'

class Repository < ActiveRecord::Base
  include Cranelift::Scm

  before_create do
    self.checkout
  end

  before_destroy do
    self.delete_files
  end

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
    begin
      self.info.rev
    rescue
      '--'
    end
  end

  def project_path
    # Assumimos que o nome é sempre validado (sanitizado)
    @project_name ||= sanitize_string_to_folder_name(self.project.name)
    @repository_name ||= sanitize_string_to_folder_name(self.name)

    REPOS_PATH.join(@project_name, @repository_name).to_s
  end

private
  def check_valid_repository
    errors.add(:url, 'especificada não é um repositório svn válido') if self.svn.info(url).nil?
  end

  def sanitize_string_to_folder_name(s)
    s.downcase.gsub(/[\x00\/\\:\*\?\"<>\| ]/, '_')
  end
end
