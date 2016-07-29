MyApp.get "/api/pokemon/:name" do

	@name = params[:name]
	@file = 'Data_File/pokedex.csv'
	@pokedex = Pokedex.new(@file)
	@all_records = @pokedex.all_records()
	@internalapi = InternalAPI.new(@all_records)
	@all_hash = @pokedex.change_the_arrays()
	@selected = @pokedex.return_specific_hash()

	if @selected.is_a? Array
		return @selected.to_json
	else
		return @selected
	end

end