require "test_helper"

describe MoviesController do

  it "should get index" do
    get movies_path
    value(response).must_be :success?
  end


  describe "API Testing" do

    it "is a real working route and returns JSON" do
      # Act
      get movies_path

      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success

    end

    it "returns an Array" do
      # Act
      get movies_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_kind_of Array
    end

    it "returns all of the movies" do
      # Act
      get movies_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body.length).must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      fields = %w(id release_date title)

      # Act
      get movies_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert that each
      body.each do |movie|
        expect(movie.keys.sort).must_equal fields
        expect(movie.keys.length).must_equal fields.length
      end
    end

    describe "show api testing" do

      it "returns movies with exactly the required fields" do
        id = movies(:movie1).id

        get movie_path(id)
        must_respond_with :success

      end

      it "returns a 404 not found page for invalid movie" do
        fields = %w(id release_date title)

        # Act
        get movie_path(-1)

        must_respond_with :not_found
      end
    end

    describe "create" do
      let(:movie_data) {
        {
          title: "Jack the Movie",
          overview: "A cool movie",
          release_date: "Oct 23 2018",
          inventory: 10
        }
      }

      it "creates a new movie given valid data" do
        expect {
        post movies_path, params: { movie: movie_data }
      }.must_change "Movie.count", 1

        body = JSON.parse(response.body)

        expect(body).must_be_kind_of Hash
        expect(body["movie"]).must_include "id"

        movie = Movie.find(body["movie"]["id"].to_i)

        expect(movie.title).must_equal movie_data[:title]
        must_respond_with :success

      end

      it "returns an error for invalid movie data" do
        # arrange
        movie_data["title"] = nil

        expect {
        post movies_path, params: { movie: movie_data }
      }.wont_change "Movie.count"

        body = JSON.parse(response.body)

        expect(body).must_be_kind_of Hash
        expect(body).must_include "message"
        expect(body["message"]).must_include "title"
        must_respond_with :bad_request
      end

    end

  end
end
