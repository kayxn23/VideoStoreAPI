require "test_helper"


# has_many :rentals
# has_many :customers, through: :rentals

describe Movie do
  let(:movie) { movies(:movie1) }

  it "must be valid" do
    value(movie).must_be :valid?
  end

  it "must have required fields" do
    fields = [:title, :release_date]

    fields.each do |field|
      expect(movie).must_respond_to field
    end
  end

  describe 'Validations' do
    it 'must have a movie title' do
      movie.title = nil

      valid = movie.save
      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :title
    end

    it 'must have registered_at ' do
      movie.release_date = nil

      valid = movie.save
      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :release_date
    end

  end #end of validations block


  describe 'Relationships' do
    # has_many :rentals
    # has_many :customers, through: :rentals
    it 'can have many customers' do
      movie.rentals << rentals(:rental1)
      movie.rentals << rentals(:rental2)
      rentals = movie.rentals

      expect(rentals.length).must_be :>=, 2
      rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end

    end
  end


end
