Rails.application.routes.draw do
  devise_for :users
  resources :boards
  resources :posts, except: [:index] do
    resources :saves, shallow: true
  end

  post "/create_post/:current_step/validate_step", to: "wizards#validate_step", as: 'validate_post_wizard'
  get "/create_post/:current_step", to: "wizards#step1", as: 'post_wizard'
  resources :locations, except: [:new, :create]
  post "/photos/:photo_id/locations", to: "locations#create"
  get 'profile/:id', to: 'profiles#show', as: 'profile'
  get 'search/:lng/:lat(/:range)', to: 'search#search', as: 'search', :constraints => {:lat => /\-?\d+(.\d+)?/, :lng => /\-?\d+(.\d+)?/ , :range => /\d+/}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"
end
