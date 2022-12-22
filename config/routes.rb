Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root 'homes#top'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :users, only:[:show]
    get 'recipes/search'
    get 'shops/search'
    get 'items/search'
    resources :recipes, :shops, :items
    namespace :tags do
      resources :recipes, :shops, :items, only:[:index, :show]
    end
  end
  namespace :admin do
    get 'top' => 'homes#top'
    resources :users, only:[:index, :show, :edit, :update]
    resources :posts, only:[:show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
