MyApp.get "/searchresults" do

	@title = "Pok&eacute;mon Search Results"
	@file = 'Data_File/pokedex.csv'
	@search_input = params[:search]
	@pokedex = Pokedex.new(@file)
	@all_records = pokedex.all_records()
	@search_results = PokedexFind(@file,@all_records)
	@search_error = "No Results Found"

	erb :"pokedex/search_results"
end