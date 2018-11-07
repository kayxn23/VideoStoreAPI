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
          expect(Rental.last.movie.available_inventory).must_equal 9
          expect(Rental.last.customer.movies_checked_out_count).must_equal 1
          expect(Rental.last.customer_id).must_equal body["customer_id"]
          expect(Rental.last.movie_id).must_equal body["movie_id"]


          must_respond_with :success

        end

        it "won't create a rental and won't increase customer movie count for invalid params" do
          expect {
            post checkout_path, params: { customer_id: customer1.id, movie_id: -1 }
          }.wont_change "Rental.count"
          expect(customer1.movies_checked_out_count).must_equal 0
          must_respond_with :bad_request
        end

        it "won't create a rental and won't decrease movie available inventory for invalid params" do
          expect {
            post checkout_path, params: { customer_id: -1, movie_id: movie1.id }
          }.wont_change "Rental.count"
          expect(movie1.available_inventory).must_equal 10
          must_respond_with :bad_request
        end
  end #describe block checking end

  describe "checkin" do
    let(:customer1) {customers(:customer1)}
    let(:movie1) {movies(:movie1)}

    it "finds a rental with valid params" do
      post checkout_path, params: { customer_id: customer1.id, movie_id: movie1.id }

      expect {
        post checkin_path, params: { customer_id: customer1.id, movie_id: movie1.id }
      }.wont_change "Rental.count"

    expect(Rental.last.movie.available_inventory).must_equal 10
    expect(Rental.last.customer.movies_checked_out_count).must_equal 0
    end

  end







end
