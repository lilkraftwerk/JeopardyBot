require 'json'
require 'marky_markov'

markov = MarkyMarkov::Dictionary.new('dictionary') # Saves/opens dictionary.mmd


100.times do 
  puts markov.generate_n_sentences 1
  puts "*" * 10
  puts
end