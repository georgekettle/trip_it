Rails.application.routes.draw do
  get 'search', to: 'search#search', as: 'search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :owners, only: [:index, :new, :create, :show]
  root :to => "pages#home"
end
