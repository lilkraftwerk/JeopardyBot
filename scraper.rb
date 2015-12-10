require 'nokogiri'
require 'json'
require 'open-uri'

class JeopardyScraper
  def initialize(game_number)
    @doc = Nokogiri::HTML(open("http://www.j-archive.com/showgame.php?game_id=#{game_number}"))
    get_categories
    get_clues_and_values
    puts "clues length is #{@clues.length}, cats length is #{@categories.length}"
  end

  def get_categories
    @categories = []
    @doc.css('td').css('.category_name').each {|cat| @categories << cat.text }
    @categories = @categories[0..-2]
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

