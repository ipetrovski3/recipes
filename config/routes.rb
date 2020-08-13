Rails.application.routes.draw do
  root 'recipes#index'

  resources :users

  resources :recipes

  get '/recipes/:id/edit_ingredients', to: 'recipes#edit_ingredients', as: :edit_ingredients
  patch '/recipes/:id', to: 'recipes#update_ingredients'

  get '/recipes/:id/edit_instructions', to: 'recipes#edit_instructions', as: :edit_instructions
  patch '/recipes/:id', to: 'recipes#update_instructions'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
