module SessionMacros
  def login
    before(:each) do
      @user = FactoryGirl.create(:user)
      @request.session[:user_id] = @user.id
    end
  end

  def current_user
    User.find(request.session[:user])
  end
end
