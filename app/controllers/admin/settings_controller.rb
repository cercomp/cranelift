class Admin::SettingsController < ApplicationController
  before_filter :authenticate!
  # GET /admin/settings
  # GET /admin/settings.json
  def index
    @settings = Setting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settings }
    end
  end

  def update_all
    render :text => "<pre>" + params["setting"].to_a.join("\n")
    return
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

end
