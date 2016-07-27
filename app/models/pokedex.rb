require "httparty"
require "pry"
require "json"


class Pokedex

	# This method saves a new Pokemon's information in a text file as an Array
	#
	# new_pokemon is an array of traits for individual pokemon
	#
	# SAVES DATA TO FILE
	def Pokedex.save_record(new_pokemon,file)
		require 'csv'

		CSV.open(file, "a") do |csv|

			csv << new_pokemon
		end
	end





end
