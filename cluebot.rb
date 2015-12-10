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
    @markov = MarkyMarkov::Dictionary.new('dict', 2)
    @clues.each do |clue|
      @markov.parse_string(clue)
    end
  end

  def make_sentence
    length = 200
    # puts "making sentence..."
    until length < 120 && length > 50
      @sentence = @markov.generate_n_words(rand(20))
      length = @sentence.length 
    end
    # puts "done making sentence"
    format_sentence 
  end

  def format_sentence

    @sentence = @sentence.upcase
  end

  def get_sentence
    make_sentence
    @sentence
  end
end