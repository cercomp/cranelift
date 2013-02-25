require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  test "project with name validation" do
    assert projects(:one).valid?
  end

  test "rename directory on file system" do
    project = projects(:one)
    project.update_attribute :name, "12345teste"
    new_slug = "12345new-project-name"
    
    prepare_directories(project.slug, new_slug)

    project.update_attributes(name: '12345New Project Name')
    assert Dir[REPOS_PATH + "*"].include?(REPOS_PATH.join(new_slug).to_s)
  end


  # Para a execução correta do teste
  # Cria o diretorio para o projeto (caso não exista)
  # E apaga o diretório do novo nome
  def prepare_directories(first_name, second_name)
    unless File.directory?(REPOS_PATH.join(first_name).to_s)
      FileUtils.mkdir(REPOS_PATH.join(first_name).to_s)
    end

    if File.directory?(REPOS_PATH.join(second_name).to_s)
      FileUtils.rm_rf(REPOS_PATH.join(second_name).to_s)
    end
  end

end
