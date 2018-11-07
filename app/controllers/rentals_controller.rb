

class RentalsController < ApplicationController
  def checkout
    @movie = Movie.find_by(id: rental_params[:movie_id])
    @customer = Customer.find_by(id: rental_params[:customer_id])

<<<<<<< HEAD
    if @movie.nil? || @customer.nil?
=======
    rental = Rental.new(customer_id: @customer.id, movie_id: @movie.id,
      checkout_date: Date.today, due_date: Date.today + 7)
      rental.save



    # rental = Rental.new(rental_params)
    # customer = Customer.find_by(id: params[:id])
    # movie = Movie.find_by(id: params[:id])
    # rental.customer_id = customer.id
    # rental.movie_id = movie.id
    #
    # rental.checkout_date = Date.today
    # rental.due_date = Date.today + 7
    #
    if rental.save
      render json: rental.as_json(only: [:customer_id, :movie_id]),
      status: :ok
    else
>>>>>>> 6fc37bb360aa1d8628d7bb4880497f0b366ad28b
      render json: {
        ok: false, message: "not found"
        }, status: :bad_request
    else
      rental = Rental.new(customer_id: @customer.id, movie_id: @movie.id,
        checkout_date: Date.today, due_date: Date.today + 7)
      rental.save
      if rental
        render json: rental.as_json(only: [:customer_id, :movie_id]),
        status: :ok
      else
        render json: {
          ok: false,
          message: "not found"
          }, status: :bad_request
        end
      end
    end

    def checkin
    end


  private

  def rental_params
    params.permit(:customer_id, :movie_id, :checkout_date, :due_date )
  end

end
