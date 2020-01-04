Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/home'      , to: 'static_pages#home'
  get '/contest'   , to: 'static_pages#contest'
  get '/world_tour', to: 'static_pages#world_tour'

  get '/signup', to: 'users#new'
end
