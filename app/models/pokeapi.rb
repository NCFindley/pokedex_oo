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
		@species = @pokemon_api["species"]["url"]
		return @species
	end

	# This method finds the evolution chain url
	#
	# species = the request for Pokemon species information from API
	#
	# RETURNS A STRING (URL)
	def evolution_url(species)
		
		@evolution_url = species["evolution_chain"]["url"]
		return @evolution_url
	end

	# This method selects the evolution chain id number from the evolution url
	#
	# species = the request for Pokemon species information from API
	#
	# RETURNS A STRING ('INTEGER')
	def evolution_id()
		species2 = @evolution_url.split("n/")
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
	def types()
		@pokemon_types = []
		@pokemon_api["types"].each do |i|
			@pokemon_types.push(i["type"]["name"].capitalize)
		end
		return @pokemon_types
	end

	# This method selects the Pokemon's height
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("INTEGER")
	def height()
		@pokemon_api["height"]
	end

	# This method selects the Pokemon's weight
	#
	# pokemon = the request using the Pokemon's name from the API
	#
	# RETURNS STRING ("INTEGER")
	def weight()
		@pokemon_api["weight"]
	end


	# This method returns evolution path of singel pokemon
	#
	# Pokemon_info comes from api request
	#
	# RETURNS ARRAY with String Elements 

	def evolution_array(pokemon_info)


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

end


