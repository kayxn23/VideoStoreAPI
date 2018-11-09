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
    # if params[:sort].present? && SORTABLE_ATTRIBUTES.include?(params[:sort].to_sym)
    #   customers = customers.order(params[:sort].to_sym => :asc)
    # end


    it "returns an Array of customers' names in ascending order given valid optional param" do
      # Act
      # get customers_path
      # expect(Customer.last.id).must_equal 344919985

      get customers_path({"sort" => "name"})
      body = JSON.parse(response.body)

      last_id = body[2]["id"]

      expect(Customer.last.id).must_equal last_id

      # Assert
      expect(body).must_be_kind_of Array
    end

    it "(still)returns an Array of customers when passed invalid optional param" do
      # Act
      get customers_path({"sort" => "bogus"})
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
