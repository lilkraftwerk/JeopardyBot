require 'json'
require 'marky_markov'

class JeopardyMarkov
  def initialize
    @clues = []
    join_clues
    create_dictionary
  end

  def join_clues
    files = Dir["clues/*.json"]
    files.each { |dir| @clues << JSON.parse(File.open(dir).read) }
    @clues = @clues.flatten
  end

  def create_dictionary
    @clues = @clues.join(' ')
    @markov = MarkyMarkov::Dictionary.new('dict', 4)
    @markov.parse_string @clues
  end

  def get_sentence
    length = 200
    puts "making sentence..."
    until length < 120 && length > 50
      sentence = @markov.generate_n_sentences(1)
      length = sentence.length 
    end
    puts "done making sentence"
    puts sentence
    sentence[-1] = "" if sentence[-1] = "."
    sentence.upcase
  end
end