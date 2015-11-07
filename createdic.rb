require 'json'
require 'marky_markov'

markov = MarkyMarkov::Dictionary.new('dictionary') # Saves/opens dictionary.mmd

range = (1000..3991).to_a

range.each do |number|
  puts "#{number}..."
  file = JSON.parse(File.open("games/#{number}.json").read)
  file.each do |clue|
   markov.parse_string clue
  end
end

markov.save_dictionary! # Saves the modified dictionary/creates one if it didn't exist.