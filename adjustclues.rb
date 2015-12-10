require_relative 'cluebot'

test = JeopardyMarkov.new

10.times do 
  p test.get_sentence
end