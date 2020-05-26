Rails.application.routes.draw do
  devise_for :members, class_name: 'Admin::Member'
  authenticate :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :members

      get 'website/show'
      get 'website/edit'
      post 'website/update'
      patch 'website/update'

      resources :media_sermons

      resources :media_images

      resources :events

      resources :news

      get 'church/show', as: :my_church
      get 'church/edit', as: :edit_church
      patch 'church/update', as: :update_my_church
    end
  end

  get 'settings/profile'
  patch 'settings/profile' => 'settings#save_profile'
  delete 'settings/profile' => 'settings#destroy'

  devise_for :users, controllers: {
      registrations: 'user/registrations'
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
