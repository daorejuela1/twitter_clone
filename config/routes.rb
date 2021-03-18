Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Main root
  root 'main#index'
  # Users path
  get '/:username', to: 'users#show', as: 'user'
  patch '/:username/edit', to: 'users#edit', as: 'user_edit'
  # Tweet Creation
  resources :tweets, only: [:new, :create]
  # Followers & Following
  scope "/:username" do
      resources :followers, param: :username, only: :index, as: 'user_followers'
      resources :following, param: :username, only: :index, as: 'user_following'
  end
  # Following
  #get '/follow/user', to: 'follows#follow_username', as: 'follow_username'
  #put '/follow/user', to: 'follows#create'
  resources :following, param: :username, only: [:new, :create, :destroy]
  #post '/:username/follow', to: 'follows#create', as: 'follow_user'
  #post '/:username/unfollow', to: 'follows#destroy', as: 'unfollow_user'
end
