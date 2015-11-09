require 'imgkit'
require 'json'
require 'marky_markov'
require 'odyssey'
require_relative 'custom_twitter'

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
      "<div class='container'><div class='text textbox'>#{@sentence}</div></div>",
      "</body>",
      "</html>"
    ].join("")
  end

  def get_sentence
    length = 100
    until length < 95 && length > 50
      sentence = @markov.generate_n_sentences(1)
      length = sentence.length 
    end
    sentence[-1] = "" if sentence[-1] = "."
    @sentence = sentence.upcase
  end

  def generate_html
    puts "making html"
    get_sentence
    set_html
    puts @sentence
    @html
  end
end

def get_catchphrase
  ## obviously unnecessary but heck, now it scales
  [
    "Please answer in the form of a question"
  ].shuffle.shift
end

def make_file
  file_path = "tmp/file#{rand(1..100)}.jpg"
  creator = ImageCreator.new
  kit = IMGKit.new(creator.generate_html, quality: 50, width: 800, height: 600)
  kit.stylesheets << 'styles.css'
  file = kit.to_file(file_path)
  file_path
end

def tweet
  file = make_file
  twit = CustomTwitter.new
  twit.update(get_catchphrase)
end

10.times {make_file}