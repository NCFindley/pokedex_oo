MyApp.get "/view" do 
require 'active_support/all'



	@title="View Your Pok&eacute;mon"

	@file = 'Data_File/pokedex.csv'

	@name = params[:name].downcase
	@gender = params[:gender]
	@type = ""
	@cp = params[:cp]
	@hp = params[:hp]
	@favorite = params[:favorite]


	#Checks if gender exist. If gender exist means that view page is coming from add pokemon page
	#and will need to save record and display the info. 	
	if params[:gender].present? != false
	
		@pokemon_api = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
		@pokeapi = Pokeapi.new(@name,@pokemon_api)
		
		# Assign the Pokemon's ID taken from the @pokemon request
		@pokemon_id = @pokeapi.id()

		# Assign the species URL taken from @pokemon request (needed to find the correct evolution ID)
		@species_url = @pokeapi.species_url()
		# Use the newly found species URL to make another API request
		@species = HTTParty.get(@species_url)
		# Extract the evolution URL from the data in @species
		@evolution_url = @pokeapi.evolution_url(@species)
		# Select only the evolution ID number from the evolution URL!
		@evolution_id = @pokeapi.evolution_id()
		# Finally use the evolution ID to get the information about the Pokemon's evolution chain
		@evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@evolution_id}")
		@evolution_array = @pokeapi.evolution_array(@evolutions)

		@stage1 = @evolution_array[0].capitalize
		@stage2 = @evolution_array[1].capitalize
		@stage3 = @evolution_array[2].capitalize

		@height = @pokeapi.height()
		@weight = @pokeapi.weight()

		@type_array = @pokeapi.types()


		@new_pokemonarray = []
		@new_pokemonarray << @name.capitalize
		@new_pokemonarray << @height
		@new_pokemonarray << @weight
		@new_pokemonarray << @gender
		@new_pokemonarray << @cp
		@new_pokemonarray << @hp
		@new_pokemonarray << @favorite
		@new_pokemonarray << @stage1
		@new_pokemonarray << @stage2
		@new_pokemonarray << @stage3 

		# @types_array = Pokeapi.types_length(@types_array)
		# If pokemon have multiple types save to array and type variable.
	
		@type_array.each do |record|

			@new_pokemonarray << record

			@type = @type + " " + record

		end
		@pokedex = Pokedex.new(@file)
		@pokedex.all_records()
		@pokedex.delete_record(@name)
		@pokedex.save_record(@new_pokemonarray)

	elsif params[:name].present? != false


		@pokedex = Pokedex.new(@file)
		@all_pokemon = @pokedex.all_records()
		@pokedexFind = PokedexFind.new(@file,@all_pokemon)
		
		@found_array = @pokedexFind.find_record(@name)

		if @found_array != false

			@height = @found_array[1].to_f / 10 * 3.28
			@height = @height.round(2)
			@weight = @found_array[2].to_i / 4.54
			@weight = @weight.round(2)
			@gender = @found_array[3]
			@cp = @found_array[4]
			@hp = @found_array[5]
			@favorite = @found_array[6]
			@stage1 = @found_array[7]
			@stage2 = @found_array[8]
			@stage3 = @found_array[9]
			@type = @pokedexFind.display_type(@found_array)
	
		else
			@name = "No Pokemon Found"
		end
	end

	if @favorite == "on"
		@favorite = "yes"
	else
		@favorite = "no"
	end

	erb :"pokedex/view"

end