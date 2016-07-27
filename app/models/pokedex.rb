require "httparty"
require "pry"
require "json"



class Pokedex

	def initialize(file)

		@file = file
	end


	# This method saves a new Pokemon's information in a text file as an Array
	#
	# new_pokemon is an array of traits for individual pokemon
	#
	# SAVES DATA TO FILE
	def Pokedex.save_record(new_pokemon)
		require 'csv'

		CSV.open(@file, "a") do |csv|

			csv << new_pokemon
		end
	end

	def Pokedex.pokedex_all_records()
		require 'csv'
		# Array to add all Pokemon to
		@pokemon_array = []
		# Assign the file name to a variable
		# For each line (Array) in the Pokedex file
		CSV.foreach(file) do |record|
			# Add each one to the empty Array
			 @pokemon_array.push(record)
		end
		# Return Array containing all of the Pokemon from the Pokedex
		return @pokemon_array
	end

end

class PokedexFind < Pokedex


	def Pokedex.pokedex_find_record(name_pokemon,pokedex_array)

		pokedex_array.each do |record|
			
			if name_pokemon.capitalize == record[0]
				return record

			end
		end
		return false
	end


	# This method searches the Pokedex for any matching words put into the search
	#
	# search_input = params[:search] (whatever text is put into the search box)
	# pokemon_array represents all Pokemon in the Pokedex
	#
	# RETURNS ARRAY
	def Pokedex.pokedex_find_by_trait(pokemon_array, search_input)
		results_array = []
		# Iterate over each of the Pokemon in the Pokedex
		pokemon_array.each do |pokemon|
			found = "no"
			# Iterate over each trait of each of those Pokemon
			pokemon.each do |trait| 
				# If any of the traits match the search input
				if trait == search_input && found == "no"
					# Return those Pokemon
					results_array << pokemon
					found = "yes"
				end
			end
		end
		# If there aren't any matches found in the Pokedex then return false
		return results_array
	end




	# This method adds saved data to hashes to be displayed as JSON
	#
	# all_as_arrays = Pokedex.all(file)
	#
	# RETURNS ARRAY (OF HASHES)


	def Pokedex.change_the_arrays(all_as_arrays)
		new_hash = {}
		new_array = []

			all_as_arrays.each do |pokemon|

				new_hash["name"] = pokemon[0]
				new_hash["height"] = pokemon[1]
				new_hash["weight"] = pokemon[2]
				new_hash["gender"] = pokemon[3]
				new_hash["cp"] = pokemon[4]
				new_hash["hp"] = pokemon[5]
				new_hash["favorite"] = pokemon[6]
				new_hash["stage1"] = pokemon[7]
				new_hash["stage2"] = pokemon[8]
				new_hash["stage3"] = pokemon[9]
				new_hash["type1"] = pokemon[10]
				new_hash["type2"] = pokemon[11]

			  new_array.push(new_hash.dup)
			end	
		return new_array
	end

	# array_hash = Pokedex.change_the_arrays(all_as_arrays)
	# given_name = name passed into url
	def Pokedex.return_specific_hash(array_hash, given_name)
		single_pokemon = []
		array_hash.each do |hsh|
			if hsh["name"] == given_name
				single_pokemon.push(hsh)
			end
		end
		if single_pokemon.empty?
			return "<h1>There is no data for the Pokemon you have requested.</h1>" + "<br>" +

			"<h3>Double check your spelling and try again just in case.</h3>"

		else
			return single_pokemon
		end
	end

end
