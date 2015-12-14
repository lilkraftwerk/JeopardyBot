require 'imgkit'
require 'json'
require 'pathname'

font_dir = File.join(Dir.home, ".fonts")

class ImageCreator
  def initialize(cluebot)
    @cluebot = cluebot
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
      "<div class='container'><div class='text textbox'>#{@sentence.upcase}</div></div>",
      "</body>",
      "</html>"
    ].join("")
  end

  def get_sentence
    @sentence = @cluebot.result[:clue]
  end

  def generate_html
    puts "making html"
    set_html
    puts @sentence
    @html
  end
end
