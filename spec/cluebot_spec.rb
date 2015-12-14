require_relative '../cluebot'


10000.times do 
  bot = ClueBot.new
  length = bot.get_game
  p length
end
