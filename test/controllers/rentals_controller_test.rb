require "test_helper"

describe RentalsController do

  # it "should get checkout" do
  #   post checkout_path
  #   value(response).must_be :success?
  # end

  # it "should get checkin" do
  #   post checkin_path
  #   value(response).must_be :success?
  # end



  describe "Checkout Testing" do
    let(:customer1) {customers(:customer1)}
    let(:movie1) {movies(:movie1)}

    it "creates a rental with all valid params" do

      expect {
        post checkout_path, params: { customer_id: customer1.id, movie_id: movie1.id }
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      # expect(body[“rental”]).must_include “id”
      expect(Rental.last.customer_id).must_equal body["customer_id"]
      expect(Rental.last.movie_id).must_equal body["movie_id"]
      must_respond_with :success

    end

    it "is invalid with a missing param" do
      expect {
        post checkout_path, params: { customer_id: customer1.id, movie_id: -1 }
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end

  end

    # it "returns an error for invalid movie data" do
    #   # arrange
    #   movie_data["title"] = nil
    #
    #   expect {
    #   post movies_path, params: { movie: movie_data }
    # }.wont_change "Movie.count"
    #
    #   body = JSON.parse(response.body)
    #
    #   expect(body).must_be_kind_of Hash
    #   expect(body).must_include "message"
    #   expect(body["message"]).must_include "title"
    #   must_respond_with :bad_request
    # end





end
