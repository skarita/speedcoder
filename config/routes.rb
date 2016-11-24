Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, :snippets, :attempts

  namespace :api do
    resources :users, :snippets, :attempts
  end

  get '/session/new', to: 'session#new'
  post '/session', to: 'session#create'
  delete '/session', to: 'session#destroy'

  get '/', to: 'users#home'
  # get '/snippet/index', to: 'snippets#index'
  get '/languages', to: 'snippets#languages'
  get '/languages/javascript', to: 'snippets#javascript'
  get '/languages/ruby', to: 'snippets#ruby'
  get '/languages/other', to: 'snippets#others'
end
