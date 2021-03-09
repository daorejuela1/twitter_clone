Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  get '/:username', to: 'user#show', as: 'user'
  patch '/:username/edit', to: 'user#edit', as: 'user_edit'
end
