require "test_helper"

describe CustomersController do

  it "should get index" do
    get customers_path
    value(response).must_be :success?
  end

  describe "API Testing" do
    it "is a real working route and returns JSON" do
      # Act
      get customers_path

      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns an Array" do
      # Act
      get customers_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_kind_of Array
    end

    it "returns all of the customers" do
      # Act
      get customers_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body.length).must_equal Customer.count
    end

    it "returns movies with exactly the required fields" do
      fields = %w(id movies_checked_out_count name phone postal_code registered_at)

      # Act
      get customers_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert that each
      body.each do |customer|
        expect(customer.keys.sort).must_equal fields
        expect(customer.keys.length).must_equal fields.length
      end
    end

  end
end
