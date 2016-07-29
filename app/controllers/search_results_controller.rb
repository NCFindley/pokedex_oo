MyApp.get "/searchresults" do

	@title = "Pok&eacute;mon Search Results"
	@file = 'Data_File/pokedex.csv'
	@search_input = params[:search]
	@pokedex = Pokedex.new(@file)
	@all_records = @pokedex.all_records()
	@pokedexFind = PokedexFind(@file,@all_records)
	@searchresults = pokedexFind.find_by_trait(@search_input)
	@search_error = "No Results Found"

	erb :"pokedex/search_results"
end