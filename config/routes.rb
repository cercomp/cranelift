Cranelift::Application.routes.draw do
  # session routes
  get    'login'               => 'session#login'
  post   'login'               => 'session#create_session'
  delete 'logout'              => 'session#logout'
  get    'signup'              => 'session#signup'
  post   'signup'              => 'session#create_user'
  get    'forgot_password'     => 'session#forgot_password'
  post   'forgot_password'     => 'session#restore_password'
  get    'reset_password/:id'  => 'session#reset_password', as: :reset_password
  put    'reset_password/:id'  => 'session#update_password', as: :reset_password

  resource :profile, only: [:edit, :update]

  # autoupdate
  # exemple: curl -d id=teste -d project_id=teste -d repository[version]=47 localhost:3000/autoupdate
  match '/autoupdate' => 'projects/repositories#update', as: :autoupdate

  resources :projects, only: [:index, :show] do
    resources :repositories,
              controller: 'projects/repositories',
              only: [:show, :update] do
      resource :auth, controller: 'projects/repositories/auth', only: [:new, :create]
    end
  end

  namespace :admin do
    resource :settings, only: [:show, :update]

    resources :ips, except: :show
    resources :logs, only: :index

    resources :users, except: [:delete, :show] do
      member do
        get :activate
        get :inactivate
      end
    end

    resources :roles do
      member do
        get :add_permission
        post :save_permission, :include_permission, :remove_permission
      end
    end

    resources :projects, except: [:index, :show] do
      resources :repositories, controller: 'projects/repositories', except: [:index, :show]
    end
  end

  root to: 'pages#home'
end
