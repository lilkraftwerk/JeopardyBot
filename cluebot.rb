require 'json'
require 'marky_markov'

class ClueBot
  attr_reader :result

  def initialize
    @result = {}
  end

  def get_game
    game_filename = Dir["games/*.json"].shuffle.shift
    @game = JSON.parse(File.open(game_filename).read)
    @game.length
  end

  def format_result
    #change this to full number of games
    category_number = rand(12)
    category = @game[category_number.to_s]
    @result[:category] = category["title"]
    clue = category["clues"].shuffle.shift
    @result[:value] = clue[0]
    @result[:clue] = clue[1]
    puts "length of clue is "
    puts @result[:clue].length
    get_game if @result[:clue].length > 130 || result[:clue].length < 20 
  end
end
