Rails.application.routes.draw do
  resources :scores
  resources :students

  get '/students/:id/edit_score' => 'students#edit_score'
  post '/scores/relay' => 'scores#relay'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
