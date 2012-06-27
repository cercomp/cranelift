module Admin::ProjectsHelper
  def user_collection
    User.order('LOWER(name)').map do |user|
      ["#{user.name.titleize} (#{user.email})", user.id]
    end
  end
  
end
