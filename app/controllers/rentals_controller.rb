

class RentalsController < ApplicationController
  def checkout

    @movie = Movie.find_by(id: rental_params[:movie_id])
    @customer = Customer.find_by(id: rental_params[:customer_id])

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
      render json: {
        ok: false,
        message: rental.errors.messages
        }, status: :bad_request
      end
    end

    def checkin
    end


  private

  def rental_params
    params.permit(:customer_id, :movie_id, :checkout_date, :due_date )
  end

end
