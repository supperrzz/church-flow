Rails.application.routes.draw do
  post 'notify/mux'
  # devise_for :members, class_name: 'Admin::Member'
  authenticated :user, lambda { |u| u.admin? } do
    namespace :admin, path: '/' do

      root to: 'website#show', as: :root
      get '/dashboard' => 'dashboard#index', as: :dashboard
      get 'website/edit'
      post 'website/update'
      patch 'website/update'

      resources :live_streams, only: %i[index create], path: 'streams'
      resources :live_streams, only: %i[destroy show new], path: 'stream'

      resources :media_sermons, only: %i[index create], path: 'sermons'
      resources :media_sermons, except: %i[index create], path: 'sermon'

      resources :media_images, path: 'gallery'

      resources :events, only: %i[index create], path: 'events'
      resources :events, except: %i[index create], path: 'event'

      resources :news, only: %i[index create], path: 'news'
      resources :news, except: %i[index create], path: 'article'

      resources :members, only: %i[index create], path: 'members'
      resources :members, except: %i[index create], path: 'member'

      get '/church' => 'church#show', as: :my_church
      get 'church/edit', as: :edit_church
      patch 'church/update', as: :update_my_church
    end
  end

  get 'settings/profile'
  patch 'settings/profile' => 'settings#save_profile'

  # Only allow admin to delete it's profile
  authenticated :user, lambda { |u| u.admin? } do
    delete 'settings/profile' => 'settings#destroy'
  end

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_scope :user do
    get 'invitation/accept', as: :accept_invitation
    post 'invitation/complete', as: :complete_invitation
  end

  authenticated :user, lambda { |u| u.super_admin? } do
    root to: 'home#index', as: :super_admin_root
    resources :admins
  end

  unauthenticated :user do
    root to: 'home#index', constraints: { subdomain: 'www' }

    # Public routes
    constraints lambda { |req| req.subdomain != 'www' } do
      root to: 'public/home#index', as: :church_subdomain

      namespace :public, path: '/' do
        get 'news' => 'news#index'
        get 'article/:id' => 'news#show', as: :article

        get 'sermons' => 'sermons#index'

        get 'events' => 'events#index'
        get 'event/:id' => 'events#show', as: :event
        get 'streams' => 'live_streams#index', as: :streams
      end
    end
  end
end
