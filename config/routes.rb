Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/customers', to: 'customers#index' 

  #get customers -> returns id, name registered_at, postal_code, phone
  #get movies
  #get movies/:id
  #post movies  -> returns id of the new movie just created
  #post /rentals/check-out
  #post /rentals/check-in

end
