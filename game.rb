require 'json'

class Game
  attr_reader :result, :filename

  def initialize(options = {})
    @result = {}
    @options = options
    @options[:filename] ? get_specific_game : get_random_game
    get_random_clue
  end

  def get_specific_game
    @filename = @options[:filename]
    @game = JSON.parse(File.open(@filename).read)
  end

  def get_random_game
    @filename = Dir["games/*.json"].shuffle.shift
    @game = JSON.parse(File.open(@filename).read)
  end

  def get_random_clue
    category = @game[rand(12).to_s]
    @result[:category] = category["title"]
    total_clue = category["clues"].shuffle.shift
    @result[:value] = total_clue[0]
    @result[:clue] = total_clue[1] 
    get_random_clue if @result[:clue].length > 130 || @result[:clue].length < 20 
  end
end
