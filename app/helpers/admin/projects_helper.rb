module Admin::ProjectsHelper
  def user_collection
    User.order('LOWER(first_name)').map do |user|
      ["#{user.name.titleize} (#{user.email})", user.id]
    end
  end

  def options_for_version(repository, revision)
    options_for_select(repository.scm.log.map{|i| i[1]}, revision) rescue ''
  end
  
end
