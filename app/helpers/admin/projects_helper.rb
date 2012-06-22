module Admin::ProjectsHelper
  def users_collection
    User.all.map do |user|
      [user.name.capitalize, user.id]
    end
  end
  
end
