Rails.application.routes.draw do
  resources :posts
  resources :emissions
  resources :animateurs
  get "/post/animateurs/:title-:id", to: "animateurs#show"
  get "/post/emissions/:title-:id", to: "emissions#show"
  root to: 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
