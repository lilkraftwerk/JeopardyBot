require 'nokogiri'
require 'json'
require 'open-uri'

class JeopardyScraper
  def initialize(game_number)
    @number = game_number 
    @game = {}
    @doc = Nokogiri::HTML(open("http://www.j-archive.com/showgame.php?game_id=#{game_number}"))
    get_categories
    if @game == {}
      write_empty_game
      return
    else
      get_clues_and_values
      assign_clues_to_category
      write_game
    end
  end

  # game = {
    # 1: {
      # category: 'blah blah blah',
      # clues: [1, 2, 3]
    # }
  # }

  def get_categories
    @doc.css('td').css('.category_name').each_with_index do |category, index| 
      next if index == 12
      @game[index] = {}
      @game[index][:title] = category.text 
      @game[index][:clues] = []
    end
  end

  def get_clues_and_values
    @clues = []
    @doc.css('td').css('.clue').each do |clue|
      value = clue.css('.clue_value').text
      clue_text = clue.css('.clue_text').text
      value = "DAILY DOUBLE" if value == ""
      @clues << [value, clue_text]
    end
    @clues = @clues[0..-2]
    @round_one_clues = @clues[0..29]
    @round_two_clues = @clues[30..59]
  end

  def assign_clues_to_category
    @round_one_clues.each_with_index do |clue, index|
      @game[index % 6][:clues] << clue
    end
    @round_two_clues.each_with_index do |clue, index|
      @game[(index % 6) + 6][:clues] << clue
    end
  end

  def write_empty_game
    empty = {empty: true}
    puts "writing empty game"
    File.open("games/#{@number}.json","w") do |f|
      f.write(JSON.pretty_generate(empty))
    end
  end

  def write_game
    puts "writing game"
    File.open("games/#{@number}.json","w") do |f|
      f.write(JSON.pretty_generate(@game))
    end
  end
end

def make_all_games
  range = 3576..4500
  range = range.to_a
  range.each do |game_number|
    puts "on number #{game_number}"
    jep = JeopardyScraper.new(game_number) unless File.exist?("games/#{game_number}.json")
  end
end

make_all_games

# game = rand(10) + 1 
# puts "Game number is #{game}"
