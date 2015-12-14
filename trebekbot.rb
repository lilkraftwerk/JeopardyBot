require 'imgkit'
require 'json'
require 'marky_markov'

require_relative 'config'
require_relative 'custom_twitter'
require_relative 'image_creator'
require_relative 'game'


class TrebekBot
  def initialize
    @game = Game.new
    @result = @game.result
  end

  def format_tweet_text
    if @result[:value] == "DAILY DOUBLE"
      @tweet_text = [
          "A Daily Double! The category is #{@result[:category]}. Good luck!"
        ]
    else
    @tweet_text = [
      "I'll take #{@result[:category]} for #{@result[:value]}, Alex",
      "#{@result[:category]} for #{@result[:value]}, Alex",
      "Let's do #{@result[:category]} for #{@result[:value]}, Alex",
      "Thanks, Alex. Let's go with #{@result[:category]} for #{@result[:value]}",
      "How about #{@result[:category]} for #{@result[:value]}, Alex?",
      "Hmm... Let's go with #{@result[:category]} for #{@result[:value]}",
      "I'll pick #{@result[:category]} for #{@result[:value]}",
      "For #{@result[:value]}, let's go with #{@result[:category]}, Alex",
      "#{@result[:value]}, #{@result[:category]}, thanks Alex",
      "#{@result[:category]} for #{@result[:value]}",
      "I'd like #{@result[:category]} for #{@result[:value]}, Alex",
      "How's #{@result[:category]} for #{@result[:value]}, Alex?",
      ].shuffle.shift
    end
  end

  def make_file
    puts "making file"
    creator = ImageCreator.new(@game)
    kit = IMGKit.new(creator.generate_html, quality: 50, width: 800, height: 600)
    kit.stylesheets << "css/styles.css"
    file = kit.to_file("tmp/file#{rand(1..100)}.jpg")
    file
  end
end

def test_file
  puts "tweeting"
  bot = TrebekBot.new
  file = bot.make_file
  twit = CustomTwitter.new
  puts "test results:"
  puts "#{bot.format_tweet_text}"
  puts file
end

def tweet
  puts "tweeting"
  bot = TrebekBot.new
  file = bot.make_file
  twit = CustomTwitter.new
  twit.update(bot.format_tweet_text, file)
end

def should_tweet?
  last_tweet_older_than_four_hours?
end

def timed_tweet
  tweet if should_tweet?
end

def last_tweet_older_than_four_hours?
  client = CustomTwitter.new
  client.is_last_tweet_older_than_four_hours
end

1000.times do 
  test_file
end