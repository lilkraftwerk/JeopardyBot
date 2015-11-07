require 'nokogiri'
require 'json'
require 'open-uri'

range = (1000..4000).to_a


range.each do |game|
  puts "on no. #{game}"
  clues = []
  doc = Nokogiri::HTML(open("http://www.j-archive.com/showgame.php?game_id=#{game}"))

  doc.css('td').css('.clue_text').each do |x|
    clues << x.text
  end

  File.open("games/#{game}.json","w") do |f|
    f.write(JSON.pretty_generate(clues))
  end
end

