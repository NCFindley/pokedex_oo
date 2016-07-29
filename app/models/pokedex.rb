require "httparty"
require "pry"
require "json"
require 'csv'


class Pokedex

	def initialize(file)

		@file = file

	end


	# This method saves a new Pokemon's information in a text file as an Array
	#
	# new_pokemon is an array of traits for individual pokemon
	#
	# SAVES DATA TO FILE
	def save_record(new_pokemon)
		

		CSV.open(@file, "a") do |csv|

			csv << new_pokemon
		end
	end

	def pokedex_all_records()
		
		# Array to add all Pokemon to
		@pokemon_array = []
		# Assign the file name to a variable
		# For each line (Array) in the Pokedex file
		CSV.foreach(@file) do |record|
			# Add each one to the empty Array
			 @pokemon_array.push(record)
		end
		# Return Array containing all of the Pokemon from the Pokedex
		return @pokemon_array
	end

	def delete_record(name_pokemon)

	
		CSV.open(@file, "w") do |csv|

			@pokemon_array.each do |record |

				if record[0] != name_pokemon.capitalize
					csv << record
				end
			end
		end	
	end

end

class PokedexFind < Pokedex

	def initialize(file,all_records)

		@file = file
		@all_records = all_records

	end

	def pokedex_find_record(name_pokemon)


		@all_records.each do |record|
			
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
	def Pokedex.pokedex_find_by_trait(search_input)
		results_array = []
		# Iterate over each of the Pokemon in the Pokedex
		@all_records.each do |pokemon|
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

	def list_of_favorites()
		# all_records contains complete list of Pokemon as an Array
		# all_records = Pokedex.pokedex_all_records(file)
		# Will contain all the favorite Pokemon
		favorite_pokemon = []
		# Iterate through each Pokemon
		@all_records.each do |pokemon|
			# Check if the Pokemon is a favorite
			if pokemon[6] == "on"
				# If so then add the Pokemon to Array
				favorite_pokemon.push(pokemon)
			end
		end
		return favorite_pokemon
	end

	# This method selects a favorite randomly to be displayed on the home page
	#
	# favorite_pokemon = Array of favorited Pokemon returned from pokedex_list_of_favorites
	#
	# RETURNS ARRAY
	def random_favorite()
		# all_records is the Array of all the Pokemon in the Pokedex
		# favorite_pokemon is the Array of favorited Pokemon
		favorite_pokemon = list_of_favorites()
		# Select a random Pokemon from the favorites Array
		random_favorite = favorite_pokemon.sample
		return random_favorite
	end

	def display_type(found_array)

		x = 11
		type = found_array[10]
			
			while x < found_array.length

				type = type + "," + found_array[x]

				x +=1
			end

			return type

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
