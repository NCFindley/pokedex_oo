MyApp.get "/searchresults" do

	@title = "Pok&eacute;mon Search Results"
	@file = 'Data_File/pokedex.csv'
	@search_input = params[:search]
	@pokedex = Pokedex.new(@file)
	@all_records = @pokedex.all_records()
	@pokedexFind = PokedexFind.new(@file,@all_records)
	@search_results = @pokedexFind.find_by_trait(@search_input)
	@search_error = "No Results Found"

	erb :"pokedex/search_results"
end