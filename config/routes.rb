Cranelift::Application.routes.draw do

  # Session routes
  get     '/login'  => 'session#new',     :as => :login
  post    '/login'  => 'session#create',  :as => :login
  delete  '/logout' => 'session#destroy', :as => :logout

  resources :password_resets


  # Pages routes
  get '/home' => 'pages#home', :as => :home


  # Users routes
  get 'editaccount' => 'users#edit'
  resources :users, :except => [:show, :destroy, :edit],
            :path_names => { :new => :signup } do
  end


  # Projects routes
  resources :projects, :only => [:index, :show] do
    resources :repositories, :controller => 'projects/repositories', :only => [:index, :show, :update]
  end


  # Admin namespace for administration
  namespace :admin do
    # Ips routes
    resources :ips, :except => :show

    # Logs routes
    resources :logs, :only => :index

    # Users routes
    resources :users

    # Roles routes
    resources :roles do
      member do
        get :add_permission
        post :save_permission, :include_permission, :remove_permission
      end
    end

    # Projects routes
    resources :projects do
      resources :repositories, :controller => 'projects/repositories'
    end

    get 'settings' => 'settings#index'
    post 'settings' => 'settings#update_all'
  end

  get 'admin' => 'admin/projects#index', :as => :admin


  # Logs routes
  resources :logs


  root :to => 'pages#home'
end
