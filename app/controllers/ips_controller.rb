# encoding: utf-8
class IpsController < ApplicationController
  before_filter :authenticate!

  def index
    redirect_if_cannot 'view', 'ips'
    @ips = Ip.all
  end


  def show
    redirect_if_cannot 'view', 'ips'
    @ip = Ip.find(params[:id])
  end

  def new
    redirect_if_cannot 'create', 'ips'
    @ip = Ip.new
  end

  def edit
    redirect_if_cannot 'update', 'ips'
    @ip = Ip.find(params[:id])
  end

  def create
    redirect_if_cannot 'create', 'ips'
    @ip = Ip.new(params[:ip])
    if @ip.save
      redirect_to @ip, notice: t('application.obj_successfully_created', :obj => 'Ip')
    else
      render action: "new"
    end
  end

  def update
    redirect_if_cannot 'update', 'ips'
    @ip = Ip.find(params[:id])
    if @ip.update_attributes(params[:ip])
      redirect_to @ip, notice: t('application.obj_successfully_updated', :obj => 'Ip')
    else
      render action: "edit"
    end
  end

  def destroy
    redirect_if_cannot 'destroy', 'ips'
    @ip = Ip.find(params[:id])
    @ip.destroy

    redirect_to ips_path, :notice => t('application.obj_successfully_destroyed', :obj => 'Ip')
  end
end
