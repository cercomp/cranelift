Cranelift::Application.routes.draw do

  # Session routes
  get     '/login'  => 'session#new',     :as => :login
  post    '/login'  => 'session#create'
  delete  '/logout' => 'session#destroy', :as => :logout


  # Pages routes
  get '/home' => 'pages#home', :as => :home


  # Users routes
  get '/editaccount' => 'users#edit', :as => :edit_user
  resources :users, :except => [:edit, :destroy], :path_names => {
    :new => :signup
  }


  # Projects routes
  resources :projects do
    resources :repositories, :controller => 'projects/repositories'
  end


  # Ips routes
  resources :ips


  # Logs routes
  resources :logs


  root :to => 'pages#home'
end
