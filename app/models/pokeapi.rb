require "httparty"
require "pry"
require "json"

class Pokeapi

	def initialize(name,pokemon_api)

		@name = name
		@pokemon_api = pokemon_api

	end

	# This method selects the Pokemon's species url
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("URL")
	def species_url()
		return @pokemon_api["species"]["url"]
	end

	# This method finds the evolution chain url
	#
	# species = the request for Pokemon species information from API
	#
	# RETURNS A STRING (URL)
	def evolution_url(species)
		species["evolution_chain"]["url"]
	end

	# This method selects the evolution chain id number from the evolution url
	#
	# species = the request for Pokemon species information from API
	#
	# RETURNS A STRING ('INTEGER')
	def evolution_id(species)
		species2 = species.split("n/")
		id = species2[1].split("/")
		return id.join('')
	end

	# This method selects the Pokemon id number
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS FIXNUM (INTEGER)
	def id()
		return @pokemon_api["id"]
	end

	# This method adds the names of a Pokemon's abilities to an Array
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS ARRAY
	def ability_names(pokemon)
		ability_names = []
		pokemon["abilities"].each do |i|
			ability_names.push(i["ability"]["name"])
		end
		return ability_names
	end



	# This method adds all the types belonging to the Pokemon passed in to an Array
	#
	# pokemon = the API request information for the Pokemon
	#
	# RETURNS ARRAY
	def types(pokemon)
		pokemon_types = []
		@pokemon_api["types"].each do |i|
			pokemon_types.push(i["type"]["name"].capitalize)
		end
		return pokemon_types
	end

	# types_array = types(pokemon)
	# def types_length(types_array)
	# 	if types_array[1] == 1
	# 		types_array[1] == ""
	# 	end
	# 	return types_array
	# end
	# This method selects the Pokemon's height
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("INTEGER")
	def height(pokemon)
		@pokemon_api["height"]
	end

	# This method selects the Pokemon's weight
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("INTEGER")
	def weight(pokemon)
		@pokemon_api["weight"]
	end


	# This method returns evolution path of singel pokemon
	#
	# Pokemon_info comes from api request
	#
	# RETURNS ARRAY with String Elements 

	def api_evolution_array(pokemon_info)


		# firstevolution = pokemon_info["chain"]["species"]["name"]
		# secevolution = pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		# thirdevolution = pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		
		evolutionarray =[]

	
		# Pokemon statement for first evolution
		evolutionarray << pokemon_info["chain"]["species"]["name"]
		


		# If statement to check for nill on second evolution
		if pokemon_info["chain"]["evolves_to"][0] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		else
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["species"]["name"]
		end

		#If Statement to check for nil on third evolution

		if pokemon_info["chain"]["evolves_to"][0] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0] == nil
			evolutionarray << "None"	
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"] == nil
			evolutionarray << "None"
		elsif pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"] == nil
			evolutionarray << "None"
		else
			evolutionarray << pokemon_info["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		end
		

		return evolutionarray

	end


	# This method adds evolution stages to a Hash for API storage
	# 
	# all_pokemon = Pokedex.pokedex_all_records(file)
	#
	# RETURNS A HASH
	def evolution_hash(all_pokemon)
		evolutions_hash = {}	

			evolutions_hash["stage1"] = all_pokemon[7]
			evolutions_hash["stage2"] = all_pokemon[8]
			evolutions_hash["stage3"] = all_pokemon[9]
		return evolutions_hash
	end

	# This method adds types to a Hash for API storage
	# 
	# types_array = types(pokemon)
	#
	# RETURNS A HASH
	def types_hash(types_array)
		types_hash = {}
			types_hash["type1"] = types_array[0]
			types_hash["type2"] = types_array[1]
			types_hash["type3"] = types_array[2]
		return types_hash
	end

	# This method takes the sorted data taken from the API request and puts it into a Hash
	#
	# types_hash = types_hash(types_array)
	# evolutions_hash = evolution_hash(evolution_array)
	# ability_hash = ability_hash(abilities_array)
	# height = height(pokemon)
	# weight = weight(pokemon)
	# name = params[:name]
	#
	# RETURNS A HASH
	def api_data_hash(name, height, weight, ability_hash, types_hash, evolutions_hash)
		data_hash = {}
		
			data_hash["name"] = name
			data_hash["height"] = height
			data_hash["weight"] = weight
			data_hash["types"] = [types_hash]
			data_hash["abilities"] = [ability_hash]
			data_hash["evolutions"] = [evolutions_hash]

		return data_hash
	end

end