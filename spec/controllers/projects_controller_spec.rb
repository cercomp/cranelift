require 'spec_helper'

describe ProjectsController do

  describe 'logged user' do
    login

    describe 'GET #index' do
      it 'render index' do
        get :index
        response.should render_template :index
      end
    end
  end
end
