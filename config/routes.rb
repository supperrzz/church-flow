Rails.application.routes.draw do
  devise_for :members, class_name: 'Admin::Member'
  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin, path: '/' do

      root to: 'website#show'
      get 'website/edit'
      post 'website/update'
      patch 'website/update'

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
  delete 'settings/profile' => 'settings#destroy'

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions'
  }

  devise_scope :user do
    get 'invitation/accept', as: :accept_invitation
    post 'invitation/complete', as: :complete_invitation
  end

  authenticate :user, lambda { |u| u.super_admin? } do
    resources :admins
  end

  root to: 'home#index'
end
