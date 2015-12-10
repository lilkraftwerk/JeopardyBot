require 'json'
require 'marky_markov'

range = (1000..3991).to_a

all = []

range.each do |number|
  puts "#{number}..."
  file = JSON.parse(File.open("games/#{number}.json").read)
  file.each do |clue|
   all << clue 
  end
end

length = all.length

total_chars = 0.0

all.each do |clue|
  total_chars += clue.length
end

p total_chars / length