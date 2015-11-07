require 'imgkit'
require 'json'
require 'marky_markov'




def generate_html
  length = 150

  until length < 120
    text = JSON.parse(File.open("clues.json", 'r').read)



    markov = MarkyMarkov::TemporaryDictionary.new
    text.each do |line|
      markov.parse_string line
    end
   
    sentence = markov.generate_n_sentences(1).upcase
    length = sentence.length
  end

  "<div class='container'><div class='test'>#{sentence}</div></div>"
end

10.times do |i|
  puts "doing #{i}"
  kit = IMGKit.new(generate_html, :quality => 100)
  kit.stylesheets << 'test.css'
  file = kit.to_file("files/file#{i}.jpg")
end
