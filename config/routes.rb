Rails.application.routes.draw do
  devise_for :users
  resources :boards
  resources :posts, except: [:index]
  # post "/posts/:id/remove_photo", to: "posts#remove_photo", as: 'remove_photo_from_post'
  resources :locations, except: [:new, :create]
  post "/photos/:photo_id/locations", to: "locations#create"
  get 'profile/:id', to: 'profiles#show', as: 'profile'
  get 'search/:lng/:lat(/:range)', to: 'search#search', as: 'search', :constraints => {:lat => /\-?\d+(.\d+)?/, :lng => /\-?\d+(.\d+)?/ , :range => /\d+/}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"
end
