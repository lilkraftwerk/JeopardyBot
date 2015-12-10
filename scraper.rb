require 'nokogiri'
require 'json'
require 'open-uri'

class JeopardyScraper
  def initialize(game_number)
    @game = {}
    @doc = Nokogiri::HTML(open("http://www.j-archive.com/showgame.php?game_id=#{game_number}"))
    get_categories
    get_clues_and_values
    assign_clues_to_category
    p @game
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
      @game[index][:category] = category.text 
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
end

game = rand(10) + 1 
game = 6
puts "Game number is #{game}"
jep = JeopardyScraper.new(game)

# GAME = 1
# doc = Nokogiri::HTML(open("http://www.j-archive.com/showgame.php?game_id=#{GAME}"))
# all = []
# cats = []



# doc.css('td').css('.category_name').each do |x|
#   cats << x.text
# end

# p cats

# doc.css('td').css('.clue').each do |x|

#   value = x.css('.clue_value')
#   p value.text
# end
# range = (1000..4000).to_a


# range.each do |game|
#   puts "on no. #{game}"
#   clues = []
#   doc = Nokogiri::HTML(open("http://www.j-archive.com/showgame.php?game_id=#{game}"))

#   doc.css('td').css('.clue_text').each do |x|
#     clues << x.text
#   end

#   File.open("games/#{game}.json","w") do |f|
#     f.write(JSON.pretty_generate(clues))
#   end
# end

# 