Rails.application.routes.draw do

  post 'rentals/check-out', to: 'rentals#checkout', as: 'checkout'
  post 'rentals/check-in', to: 'rentals#checkin', as: 'checkin'


  get '/movies', to: 'movies#index'
  post '/movies', to: 'movies#create'
  get 'movies/:id', to: 'movies#show', as: "movie"

  get '/customers', to: 'customers#index'

end
