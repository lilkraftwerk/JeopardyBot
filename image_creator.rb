require 'imgkit'
require 'json'
require 'pathname'

require_relative 'cluebot'
require_relative 'custom_twitter'

font_dir = File.join(Dir.home, ".fonts")

class ImageCreator
  def initialize
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
    markov = JeopardyMarkov.new
    @sentence = markov.get_sentence
  end

  def generate_html
    puts "making html"
    set_html
    puts @sentence
    @html
  end
end
