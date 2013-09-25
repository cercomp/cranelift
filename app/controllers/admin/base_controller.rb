# encoding: utf-8
class Admin::BaseController < ApplicationController
  before_filter :authenticate!
  before_filter :only_admin!
end
