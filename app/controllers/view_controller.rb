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
	# @evolution_url = @pokeapi.evolution_url(@species)
	# # Select only the evolution ID number from the evolution URL!
	# @evolution_id = @pokeapi.evolution_id(@evolution_url)
	# # Finally use the evolution ID to get the information about the Pokemon's evolution chain
	# @evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@evolution_id}")
	# @evolution_array = @pokeapi.api_evolution_array(@evolutions)



	# @stage1 = @evolution_array[0].capitalize
	# @stage2 = @evolution_array[1].capitalize
	# @stage3 = @evolution_array[2].capitalize

	@height = @pokeapi.height(@pokemon)
	@weight = @pokeapi.weight(@pokemon)

	@type_array = @pokeapi.types(@pokemon)


	@new_pokemonarray = []
	@new_pokemonarray << @name.capitalize
	@new_pokemonarray << @height
	@new_pokemonarray << @weight
	@new_pokemonarray << @gender
	@new_pokemonarray << @cp
	@new_pokemonarray << @hp
	@new_pokemonarray << @favorite
	# @new_pokemonarray << @stage1
	# @new_pokemonarray << @stage2
	# @new_pokemonarray << @stage3

	# @types_array = Pokeapi.types_length(@types_array)
	# If pokemon have multiple types save to array and type variable. 
	@type_array.each do |record|

		@new_pokemonarray << record

		@type = @type + " " + record

	end


	@pokedex_array = Pokedex.pokedex_all_records(@file)
	Pokedex.pokedex_delete_record(@pokedex_array,@name,@file)
	Pokedex.pokedex_save_record(@new_pokemonarray,@file)
end

end