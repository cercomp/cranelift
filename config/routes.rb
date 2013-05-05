Cranelift::Application.routes.draw do
  get '/home' => 'pages#home', :as => :home

  # Session routes
  get     '/login'  => 'session#new',     :as => :login
  post    '/login'  => 'session#create',  :as => :login
  delete  '/logout' => 'session#destroy', :as => :logout

  # autoupdate
  # exemple: curl -d id=teste -d project_id=teste -d repository[version]=47 localhost:3000/autoupdate
  match '/autoupdate' => 'projects/repositories#update', :as => :autoupdate

  resources :password_resets

  get 'editaccount' => 'users#edit'
  resources :users, :except => [:show, :destroy, :edit],
            :path_names => { :new => :signup }

  resources :projects, :only => [:index, :show] do
    resources :repositories,
              :controller => 'projects/repositories',
              :only => [:show, :update] do
      resource :auth, :controller => 'projects/repositories/auth', only: [:new, :create]
    end
  end

  namespace :admin do
    resources :ips, :except => :show
    resources :logs, :only => :index
    resources :users
    resources :roles do
      member do
        get :add_permission
        post :save_permission, :include_permission, :remove_permission
      end
    end

    resources :projects, :except => [:index, :show] do
      resources :repositories, :controller => 'projects/repositories', :except => [:index, :show]
    end

    get 'settings' => 'settings#index'
    post 'settings' => 'settings#update_all'
  end

  get 'admin' => 'admin/projects#index', :as => :admin

  resources :logs

  root :to => 'pages#home'
end
