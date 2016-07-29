MyApp.get "/api/pokemon/:name" do

	@name = params[:name].capitalize
	@file = 'Data_File/pokedex.csv'
	@pokedex = Pokedex.new(@file)
	@all_records = @pokedex.all_records()
	@internalApi = InternalAPI.new(@all_records)
	@all_hash = @internalApi.change_the_arrays()
	@selected = @internalApi.return_specific_hash(@name)

	if @selected.is_a? Array
		return @selected.to_json
	else
		return @selected
	end

end

MyApp.get "/api/all_pokemon" do

	@file = 'Data_File/pokedex.csv'
	@pokedex = Pokedex.new(@file)
	@all_records = @pokedex.all_records()
	@internalApi = InternalAPI.new(@all_records)
	@all_hash = @internalApi.change_the_arrays()

	return @all.to_json



end
