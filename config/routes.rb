Rails.application.routes.draw do
  post "audio/save"
  resources :recordings
  resources :videoplaylists
  resources :videos
  resources :cinemas
  resources :musiques
  resources :newsarticles
  resources :songs do
    member do
      get "returntime"
    end
    collection do
      get "jouerunechanson"
      get "playmusique1"
      get "playmusique"
      get "musique"
    end
    
  end
  
  get "songs/returntime"
  resources :playlists
  resources :posts
  resources :emissions
  resources :animateurs
  get "/page/cookie", to: "posts#cookie", as: :pagecookie
  get "/page/conditions", to: "posts#conditions", as: :pageconditions
  get "/post/animateur/:title-:id", to: "animateurs#show", as: :myanimateur
  get "/post/animateur/:title-:id", to: "animateurs#show", as: :voirmonanimateur
  get "/list/animateur/p", to: "animateurs#index", as: :allanimateur
  get "/list/emission/p", to: "emissions#index", as: :allemission
  get "/post/emissions/:title-:id", to: "emissions#show", as: :myemission
  get "/list/actualite/p", to: "newsarticles#index", as: :listactualite
  get "/list/musique/p", to: "musiques#index", as: :listmusique
  get "/list/cinema/p", to: "cinemas#index", as: :listcinema
  get "/post/actualite/:title-:id", to: "newsarticles#show"
  get "/post/musique/:title-:id", to: "musiques#show"
  get "/post/cinema/:title-:id", to: "cinemas#show"
  get "grille", to: "emissions#grille"
  root to: 'welcome#index'
  get "post/hit/hit", to: "hit#post"
  get "post/hit/hit-:id", to: "hit#myhit"
  get "list/evenement/p", to: "hit#event"
  get "historique", to: "hit#historique"
  post "historique", to: "hit#getsongs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: "users/registrations" }

end
