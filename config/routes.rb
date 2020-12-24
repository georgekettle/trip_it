Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users
  resources :boards
  get 'profile/:id', to: 'profiles#show', as: 'profile'
  get 'search', to: 'search#search', as: 'search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"
end
