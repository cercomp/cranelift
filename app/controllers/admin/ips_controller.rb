# encoding: utf-8
class Admin::IpsController < Admin::BaseController
  before_filter :set_ip, only: [:edit, :update, :destroy]

  def index
    @ips = Ip.all
  end

  def new
    @ip = Ip.new
  end

  def edit
  end

  def create
    @ip = Ip.new(params[:ip])

    if @ip.save
      log current_user, "Criou o IP : #{@ip.ip}/#{@ip.cidr}"

      redirect_to admin_ips_url, notice: t('application.obj_successfully_created', obj: 'Ip')
    else
      render action: "new"
    end
  end

  def update
    if @ip.update_attributes(params[:ip])
      log current_user, "Atualizou o IP : #{@ip.ip}/#{@ip.cidr}"

      redirect_to admin_ips_url, notice: t('application.obj_successfully_updated', obj: 'Ip')
    else
      render action: "edit"
    end
  end

  def destroy
    @ip.destroy

    log current_user, "Removeu o IP : #{@ip.ip}/#{@ip.cidr}"

    redirect_to admin_ips_path, notice: t('application.obj_successfully_destroyed', obj: 'Ip')
  end

  private

  def set_ip
    @ip = Ip.find(params[:id])
  end
end
