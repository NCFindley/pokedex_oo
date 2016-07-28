require 'test_helper'

class PokedexTest < Minitest::Test

	def test_all_records()
			file = 'Data_File/pokedex.csv'
			pokedex = Pokedex.new(file)
			test_array = pokedex.all_records(file)
			assert_equal(4, test_array.count)
	end
end