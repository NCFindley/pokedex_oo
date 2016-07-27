MyApp.get "/add" do 

	@title="Add New Pok&eacute;mon"
	@name = params[:name]

	erb :"pokedex/add"
end