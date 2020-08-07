Rails.application.routes.draw do
  root 'recipes#index'

  resources :users

  resources :recipes do
    resources :ingredients
    resources :instructions
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
