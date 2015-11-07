require 'imgkit'
require 'json'
require 'marky_markov'
require 'lingua'
require 'odyssey'

class ImageCreator
  def initialize
    @markov = MarkyMarkov::Dictionary.new('dictionary') # Saves/opens dictionary.mmd
    get_sentence
    set_html
  end

  def set_html
    @html = [
      "<!DOCTYPE html>",
      "<html>",
      "<head>",
      "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>]",
      "</head",
      "<body>",
      "<div class='container'><div class='test'>#{@sentence}</div></div>",
      "</body>",
      "</html>"
    ].join("")
  end

  def get_sentence
    length = 100
    until length < 95 && length > 50
      sentence = @markov.generate_n_sentences(1).upcase
      length = sentence.length 
    end
    sentence[-1] = "" if sentence[-1] = "."
    @sentence = sentence.upcase
  end

  def generate_html
    puts "making html"
    get_sentence
    set_html
    report = Lingua::EN::Readability.new(@sentence) 
    # puts report.report        # a formatted summary of statistics and measures
    p report.flesch
    p report.kincaid
    puts @sentence
    @html
  end
end




  dog = ImageCreator.new

101.times do |i|
  puts i 
  kit = IMGKit.new(dog.generate_html, :quality => 50,
                      :width   => 800,
                      :height  => 600,
            )
  kit.stylesheets << 'test.css'
  file = kit.to_file("files/file#{i}.jpg")
end
