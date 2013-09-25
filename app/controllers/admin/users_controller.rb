# encoding: utf-8
class Admin::UsersController < Admin::BaseController
  before_filter :set_user, only: [:edit, :update]

  def index
    # TODO scope
    # TODO per_page
    @users = User.order('LOWER(first_name)').page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end
  
  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log current_user, "Criou o usuário #{@user.name}"

      redirect_to admin_users_url, notice: 'Usuário cadastrado com sucesso.'
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      log current_user, "Atualizou o usuário #{@user.name}"

      redirect_to admin_users_url, notice: t('profiles.update.successfully_updated')
    else
      render :edit
    end
  end

  def activate
    if toogle_active
      log current_user, "Habilitou o usuário #{@user.name}"

      redirect_to admin_users_url, notice: 'Habilitado com sucesso'
    else
      redirect_to :back
    end
  end

  def inactivate
    if toogle_active
      log current_user, "Desabilitou o usuário #{@user.name}"

      redirect_to admin_users_url, notice: 'Desabilitado com sucesso'
    else
      redirect_to :back
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:login, :first_name, :last_name, :email, :password, :password_confirmation,
                                 :admin, :role_id, :ip_block, :active, :login_type)
  end

  def toogle_active
    @user.update_attribute :active, !@user.active
  end
end
