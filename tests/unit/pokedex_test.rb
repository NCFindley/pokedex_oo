require 'test_helper'


class PokedexTest < Minitest::Test

	def setup
		super

		require 'csv'
		file = 'tests/unit/pokedex.csv'
		new_pokemon = ["ZCharmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire",
		"BCharmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire",
		"Charmander,5,2,male,35,30,on,Charmander,Charmeleon,Charizard,fire",
		"Squirtle,3,4,female,40,32,no,Squirtle,Wartortle,Blastoise,water"]

		CSV.open(file, "w") do |csv|
			
			new_pokemon.each do |record|  

				csv << record.split(",")
			end

		end
	end



	# def test_species_url
	# 	name = "charizard"
	# 	pokemon_api = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# 	pokeapi = Pokeapi.new(name,pokemon_api)
	# 	pokemon_id = pokeapi.id()
	# 	species_url = pokeapi.species_url()

	# 	assert_kind_of(String, species_url)
	# 	refute_nil(species_url)
	# end

	# def test_pokemon_id
	# 	name = "charizard"
	# 	pokemon_api = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# 	pokeapi = Pokeapi.new(name,pokemon_api)
	# 	id = pokeapi.id()

	# 	assert_kind_of(Fixnum, id)
	# 	refute_nil(id)

	# end

	# def test_height
	# 	name = "gloom"
	# 	pokemon_api = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
	# 	pokeapi = Pokeapi.new(name,pokemon_api)
	# 	height = pokeapi.height()

	# 	assert_kind_of(Fixnum, height)
	# 	refute_nil(height)

	# end

	def test_favorite_pokemon
		file = 'tests/unit/pokedex.csv'
		pokedex = Pokedex.new(file)
		all_records =pokedex.all_records
		pokedexFind = PokedexFind.new(file,all_records)
		favorite = pokedexFind.list_of_favorites

		assert_equal(3, favorite.count)

	end

	def test_add_record
		file = 'tests/unit/pokedex.csv'
		new_pokemon = ["Charmander",5,2,"male","fire",35,30,"on","Charmander","Charmeleon","Charizard"]
		pokedex = Pokedex.new(file)
		pokedex.save_record(new_pokemon)

		test = pokedex.all_records()

		assert_equal(5,test.count)

	end

	def test_all_records
		file = 'tests/unit/pokedex.csv'
		pokedex = Pokedex.new(file)
		test = pokedex.all_records

		assert_equal(4, test.count)
	end


end