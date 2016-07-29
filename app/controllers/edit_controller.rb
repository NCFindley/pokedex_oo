MyApp.get "/edit" do

	@title="Edit Pok&eacute;mon Info"
	@file = 'Data_File/pokedex.csv'
	@name = params[:name]
	@pokedex = Pokedex.new(@file)
	@all_records = @pokedex.all_records()
	@pokedexFind = PokedexFind.new(@file,@all_records)
	@found_array = @pokedexFind.find_record(@name)

	if @found_array
			@gender = @found_array[3]
			@cp = @found_array[4]
			@hp = @found_array[5]
			@favorite = @found_array[6]

			if @favorite == "on"
				@favorite = "yes"
			else
				@favorite = ""
			end

	else
		@title = "No Pokemon Found"
	end

	
	erb :"pokedex/edit"

end