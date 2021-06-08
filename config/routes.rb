Rails.application.routes.draw do
  # get 'redocuments/download'
  #
  get "/uploads/:report_id/:basename.:extension", :controller => "redocuments", :action => "download"
  # match "/uploads/:id/:basename.:extension", :controller => "addfiles", :action => "download", via: :get

  resources :channels do
    resources :channel_notifications, only: [:edit, :destroy, :new]
    collection do
      match :reorder_handle, via: [:put]
    end

    resources :channel_permissions, except: [:new, :edit] do
      collection do
        get 'leave_channel'
      end
    end

    resources :reports, except: [:index] do
      resources :dashboards
      member do
        match :save_pivottable, via: [:post]
        match :delete_pivottable, via: [:delete]
        match :upload_document, via: [:get, :post]
        match :share_report, via: [:get, :post]
      end
    end
  end

  get 'welcome/index'
  root to: 'welcome#index'
  get 'welcome/onedriveredirect'

  devise_for :users, :controllers => { omniauth_callbacks: 'callbacks' }

  match '/auth/microsoft_graph_auth/callback', to: 'auth#callback', via: [:get, :post]
  # Routes For Normal users
  resources :core_demographics, only: [:show]
  resources :news
  resources :one_drives, only: [:index]
  resources :roles
  resources :settings, only: [:index, :create] do
    collection do
      post 'set_user_auth'
      post 'set_notification'
      post 'set_modules'
      post 'set_content'
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
      delete 'really_destroy'
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

  # disbaled sidekiq for now
  # require 'sidekiq/web'
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'miscellaneous#blank_page'
  # Miscellaneous
  get 'miscellaneous/login',
      to: 'miscellaneous#login',
      as: :miscellaneous_login
  get 'miscellaneous/register',
      to: 'miscellaneous#register',
      as: :miscellaneous_register
  get 'miscellaneous/forgot_password',
      to: 'miscellaneous#forgot_password',
      as: :miscellaneous_forgot_password
  get 'miscellaneous/locked_screen',
      to: 'miscellaneous#locked_screen',
      as: :miscellaneous_locked_screen


end
