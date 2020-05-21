Rails.application.routes.draw do
  namespace :admin do
    get 'member/index'
    get 'member/edit'
    get 'member/new'
    get 'member/show'

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

  get 'settings/profile'
  patch 'settings/profile' => 'settings#save_profile'

  devise_for :users

  devise_scope :user do
    get 'invitation/accept', as: :accept_invitation
    post 'invitation/complete', as: :complete_invitation
  end

  resources :admins

  root to: "home#index"
end
