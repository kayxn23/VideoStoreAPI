Rails.application.routes.draw do

  post 'rentals/checkout', to: 'rentals#checkout', as: 'checkout'
  post 'rentals/checkin', to: 'rentals#checkin', as: 'checkin'

  get '/movies', to: 'movies#index'
  post '/movies', to: 'movies#create'
  get 'movies/:id', to: 'movies#show', as: "movie"

  get '/customers', to: 'customers#index'

end
