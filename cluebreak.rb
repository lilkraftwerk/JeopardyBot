require 'json'

clues = File.open('ignore/allclues.json').read
clues = JSON.parse(clues)

sliced = clues.each_slice(5000).to_a

sliced.each_with_index do |slice, index|
  File.open("clues/#{index + 1}.json","w") do |f|
    f.write(JSON.pretty_generate(slice))
  end
end

