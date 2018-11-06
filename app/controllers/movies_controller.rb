class MoviesController < ApplicationController

  def index
    movies = Movie.all
    render json: movies.as_json(only: [:id, :title, :release_date]),
    status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: { ok: false, message: "not found"},
      status: :not_found
    else
      render json: {
        ok: true,
        movie: movie.as_json(only: [:title, :overview, :inventory, :available_inventory => 1])
        }, status: :ok
      end
    end

    def create
      movie = Movie.new(movie_params)
      if movie.save
        render json: { ok: true,
          movie: movie.as_json(only: [:id])
          }, status: :ok
      else
          render json: {
            ok: false,
            message: movie.errors.messages
            }, status: :bad_request
          end
        end

        private

        def movie_params
          params.require(:movie).permit(:title, :overview, :inventory, :release_date)
        end

      end
