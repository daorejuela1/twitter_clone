Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  get '/:username', to: 'users#show', as: 'user'
  patch '/:username/edit', to: 'users#edit', as: 'user_edit'
  get '/compose/tweet', to: 'tweets#new'
  post "/compose/tweet/post", to: "tweets#create"
  get '/:username/followers', to: 'follows#show_followers', as: 'user_followers'
  get '/:username/following', to: 'follows#show_following', as: 'user_following'
  post '/:username/follow', to: 'follows#follow', as: 'follow_user'
  post '/:username/unfollow', to: 'follows#unfollow', as: 'unfollow_user'
  get '/follow/user', to: 'follows#follow_username', as: 'follow_username'
  put '/follow/user', to: 'follows#follow'
end
