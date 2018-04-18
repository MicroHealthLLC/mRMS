Rails.application.routes.draw do
  resources :channels, except: [:index] do
    member do
      match :manage_users, via: [:get, :post]
    end
    resources :reports do
      member do
        match :upload_document, via: [:get, :post]
        match :share_report, via: [:get, :post]
      end
    end
  end

  get 'welcome/index'
  root to: 'welcome#index'

  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks' }

  # Routes For Normal users
  resources :core_demographics, only: [:show]
  resources :news
  resources :roles
  resources :settings, only: [:index, :create] do
    collection do
      post 'set_user_auth'
      post 'set_notification'
      post 'set_modules'
      post 'set_theme'
      post 'set_key_providers'
    end
  end
  get 'profile_record',  to: 'user_profiles#profile_record'
  resources :employees, path: :persons, except: [:edit] do
    member do
      get 'log_in'
    end
    get 'home/index', as: 'home'
  end
  resources :enumerations do
    collection do
      post 'upload'
    end
  end

  resources :email_templates, except: [:show] do
    collection do
      get 'load_available_variables'
    end
  end
  resources :post_notes, except: [:index], controller: :notes
  resources :notes do
    collection do
      get 'get_template_note'
    end
  end

  resources :users, only: [:index, :show, :destroy] do
    collection do
      match 'recently_connected', via: [:post, :get]
      match 'active', via: [:post, :get]
      match 'audit', via: [ :get]
    end
    member do
      get 'require_change_password'
      get 'restore'
      get 'lock'
      get 'unlock'
      put 'change_password'
      put 'change_basic_info'
      put 'attachments'
      post 'image_upload'
      get 'remove_image'
    end

    resources :core_demographics, only: [:create, :update]
    resources :user_extend_demographies, only: [:create, :update], controller: :extend_demographies

  end

  namespace :extend_demographies do
    scope ':extend_demography_id' do
      resources :emails, except: [:index]
      resources :faxes, except: [:index]
      resources :phones, except: [:index]
      resources :identifications
      resources :social_media, except: [:index]
      resources :addresses, except: [:index]
    end
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    resources :exception_notifier, only: [:index, :show]
    mount Sidekiq::Web => '/sidekiq'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
