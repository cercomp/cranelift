class Admin::SettingsController < ApplicationController
  before_filter :authenticate!, :only_admin!

  def index
    @settings = Setting.all
  end

  def update_all
    # TODO quando update_attributes falhar - tratar erro
    params[:setting].each do |k, v|
      setting = Setting.find(k)
      setting.update_attributes v
    end

    respond_to do |format|
      format.html { redirect_to admin_settings_url, notice: 'Atualizado com sucesso' }
      format.json { head :no_content }
    end
  end

end
