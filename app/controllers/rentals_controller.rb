

class RentalsController < ApplicationController
  def checkout
    @movie = Movie.find_by(id: rental_params[:movie_id])
    @customer = Customer.find_by(id: rental_params[:customer_id])

    if @movie.nil? || @customer.nil?
      render json: {
        ok: false, message: "Movie with id '#{rental_params[:movie_id]}' or customer with id '#{rental_params[:customer_id]}' not found"
        }, status: :bad_request
    else
      rental = Rental.new(customer_id: @customer.id, movie_id: @movie.id,
        checkout_date: Date.today, due_date: Date.today + 7)
      rental.save
      @customer.movies_checked_out_count += 1
      @customer.save

      @movie.available_inventory -= 1
      @movie.save

      if rental
        render json: rental.as_json(only: [:customer_id, :movie_id]),
        status: :ok
      else
        render json: {
          ok: false,
          message: "Your movie was not saved, please make sure you enter a valid movie or customer"
          }, status: :bad_request
        end
      end
    end

    def checkin
      @movie = Movie.find_by(id: rental_params[:movie_id])
      @customer = Customer.find_by(id: rental_params[:customer_id])

      if @movie.nil? || @customer.nil?
        render json: {
          ok: false, message: "not found"
          }, status: :bad_request
      else
        @rental = Rental.find_by(customer_id: @customer.id, movie_id: @movie.id)

        @customer.movies_checked_out_count -= 1
        @customer.save

        @movie.available_inventory += 1
        @movie.save

        if @rental
          render json: @rental.as_json(only: [:customer_id, :movie_id]),
          status: :ok
        else
          render json: {
            ok: false,
            message: "Your rental was not returned please make sure your movie and customer are correct"
            }, status: :bad_request
        end
      end

    end


  private

  def rental_params
    params.permit(:customer_id, :movie_id, :checkout_date, :due_date )
  end

end
