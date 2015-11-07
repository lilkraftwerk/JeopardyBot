require 'json'
require 'marky_markov'

text = JSON.parse(File.open("clues.json", 'r').read).join(' ')

markov = MarkyMarkov::TemporaryDictionary.new
markov.parse_string text

sentences = []

100.times do
  sentence = markov.generate_n_sentences 1
  sentences << sentence if sentence.length < 140
end

puts sentences.join("\n\n")

markov.clear! # Clear the temporary dictionary.