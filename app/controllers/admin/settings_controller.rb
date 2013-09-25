# encoding: utf-8
class Admin::SettingsController < Admin::BaseController
  def show
    @settings = Setting.all
  end

  # TODO quando update_attributes falhar - tratar erro
  def update
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
