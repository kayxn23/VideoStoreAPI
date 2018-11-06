require "test_helper"

describe Rental do
  let(:rental1) {rentals(:rental1)}

  it "must be valid" do
    value(rental1).must_be :valid?
  end

  describe "Relationships" do
    it "has a movie" do
      rental1 = rentals(:rental1)
      rental1.must_respond_to :movie
      rental1.movie.must_be_kind_of Movie
    end
    it "has a customer" do
      rental1 = rentals(:rental1)
      rental1.must_respond_to :customer
      rental1.customer.must_be_kind_of Customer
    end

  end


end
