class Admin::RolesController < ApplicationController
  before_filter :authenticate!, :only_admin!

  def index
    @roles = Role.all
  end
end