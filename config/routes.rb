Rails.application.routes.draw do
  get 'settings/profile'
  patch 'settings/profile' => 'settings#save_profile'

  namespace :admin do
    resources :events
  end
  namespace :admin do
    resources :news
  end
  namespace :admin do
    get 'church/show', as: :my_church
    get 'church/edit', as: :edit_church
    patch 'church/update', as: :update_my_church
  end
  devise_for :users

  devise_scope :user do
    get 'invitation/accept', as: :accept_invitation
    post 'invitation/complete', as: :complete_invitation
  end

  resources :admins

  root to: "home#index"
end
