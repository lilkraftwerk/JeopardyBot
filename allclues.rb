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

File.open("allclues.json","w") do |f|
  f.write(JSON.pretty_generate(all))
end