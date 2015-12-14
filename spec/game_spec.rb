require_relative '../game'
require 'FileUtils'

def test_game(result)
  cat = test_category(result[:category])
  value = test_value(result[:value])
  clue = test_clue(result[:clue])
  cat && value && clue
end

def test_category(category)
  return false unless category.is_a?(String)
  return false unless category.length > 0 
  true
end

def test_value(value)
  return false unless value.is_a?(String)
  return false unless value.length > 0
  return false unless value[0] == '$' || value == 'DAILY DOUBLE'
  true
end

def test_clue(clue)
  return false unless clue.is_a?(String)
  return false unless clue.length >= 20 || clue.length <= 130
  true
end

good = 0
bad = []


10000.times do |x|
  if x % 1000 == 0
    p x 
  end
  game = Game.new
  if test_game(game.result)
    good += 1
  else 
    bad << game.filename
  end
end

puts "#{good} ok games, #{bad.length} bad games"

# hacked together but simply deletes scraped games with bad formatting

bad.each do |filename|
  p "removing #{filename}"
  FileUtils.rm(filename)
end



