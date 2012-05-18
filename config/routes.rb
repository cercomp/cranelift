Cranelift::Application.routes.draw do

  # Session routes
  get     '/login'  => 'session#new',     :as => :login
  post    '/login'  => 'session#create',  :as => :login
  delete  '/logout' => 'session#destroy', :as => :logout


  # Pages routes
  get '/home' => 'pages#home', :as => :home


  # Users routes
  get 'editaccount' => 'users#edit'
  resources :users, :except => [:destroy, :edit], :path_names => {
    :new => :signup } do
  end


  # Projects routes
  resources :projects, :only => [:index, :show] do
    resources :repositories, :controller => 'projects/repositories', :only => [:index, :show]
  end


  # Admin namespace for administration
  namespace :admin do
    # Ips routes
    resources :ips

    # Logs routes
    resources :logs, :only => :index

    # Users routes
    resources :users

    # Roles routes
    resources :roles

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
