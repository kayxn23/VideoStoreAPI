require "test_helper"

describe Customer do
  let(:customer) { customers(:customer1) }

  it "must be valid" do
    expect(customer).must_be :valid?
  end

  it "must have required fields" do
    fields = [:name, :registered_at, :postal_code, :phone, :movies_checked_out_count]

    fields.each do |field|
      expect(customer).must_respond_to field
    end
  end

  describe 'Validations' do
    it 'must have name' do
      customer.name = nil

      valid = customer.save
      expect(valid).must_equal false
      expect(customer.errors.messages).must_include :name
    end

    it 'must have registered_at ' do
      customer.registered_at = nil

      valid = customer.save
      expect(valid).must_equal false
      expect(customer.errors.messages).must_include :registered_at
    end

    it 'must have postal_code ' do
      customer.postal_code = nil

      valid = customer.save
      expect(valid).must_equal false
      expect(customer.errors.messages).must_include :postal_code
    end

    it 'must have phone ' do
      customer.phone = nil

      valid = customer.save
      expect(valid).must_equal false
      expect(customer.errors.messages).must_include :phone
    end

    it 'must have movies_checked_out_count ' do
      customer.movies_checked_out_count = nil

      valid = customer.save
      expect(valid).must_equal false
      expect(customer.errors.messages).must_include :movies_checked_out_count
    end
  end

  describe 'Relationships' do
    # has_many :rentals
    # has_many :movies, through: :rentals
    it 'can have many rentals' do
      customer.rentals << rentals(:rental1)
      customer.rentals << rentals(:rental2)
      rentals = customer.rentals

      expect(rentals.length).must_be :>=, 2
      rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end 

    end
  end

end
