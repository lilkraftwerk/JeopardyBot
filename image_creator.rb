require 'imgkit'
require 'json'
require 'pathname'

require_relative 'cluebot'
require_relative 'custom_twitter'

font_dir = File.join(Dir.home, ".fonts")

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
    # markov = JeopardyMarkov.new
    # @sentence = markov.get_sentence

    # placeholder 
    @sentence = "YOU CAN SAY NO TO THIS, BUT ACADEMY-AWARD WINNING RAPPER JUICY J CAN'T"
  end

  def generate_html
    puts "making html"
    get_sentence
    set_html
    puts @sentence
    @html
  end
end
