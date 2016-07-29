MyApp.get "/viewall" do 
	@title = "View All of Your Pok&eacute;mon"
	@file = 'Data_File/pokedex.csv'
	@pokedex = Pokedex.new(@file)
	@all_pokemon = @pokedex.all_records()
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	erb :"pokedex/view_all"
end