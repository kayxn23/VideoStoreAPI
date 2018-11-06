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





  describe "create (checkout)" do
    let(:rental_data) {
      {
        customer_id: 1,
        movie_id: 2

      }
    }

    it "creates a new rental given valid data" do
      expect {
      post checkout_path, params: { rental: rental_data }
    }.must_change "Rental.count", 1

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body["rental"]).must_include "id"

      rental = Rental.find(body["rental"]["id"].to_i)

      expect(rental.customer_id).must_equal rental_data[:customer_id]
      must_respond_with :success

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





end
