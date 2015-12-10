require 'json'
require 'marky_markov'

class ClueBot
  attr_reader :result

  def initialize
    @result = {}
    game_number = rand(60) + 1
    @game = JSON.parse(File.open("games/#{game_number}.json").read)
    format_result
  end

  def format_result
    #change this to full number of games
    category_number = rand(12)
    category = @game[category_number.to_s]
    @result[:category] = category["title"]
    clue = category["clues"].shuffle.shift
    @result[:value] = clue[0]
    @result[:clue] = clue[1]
  end
end
