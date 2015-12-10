require 'imgkit'
require 'json'
require 'marky_markov'

require_relative 'config'
require_relative 'custom_twitter'
require_relative 'image_creator'
require_relative 'cluebot'


class TrebekBot
  def initialize
    @cluebot = ClueBot.new
    @result = @cluebot.result
  end

  def format_tweet_text
    if @result[:value] == "DAILY DOUBLE"
      @tweet_text = [
          "A Daily Double! The category is #{@result[:category]}"
        ]
    else
    @tweet_text = [
      "I'll take #{@result[:category]} for #{@result[:value]}, Alex",
      "#{@result[:category]} for #{@result[:value]}, Alex",
      "Let's do #{@result[:category]} for #{@result[:value]}, Alex",
      "Thanks, Alex. Let's go with #{@result[:category]} for #{@result[:value]}",
      "How about #{@result[:category]} for #{@result[:value]}, Alex?",
      ].shuffle.shift
    end
  end

  def make_file
    puts "making file"
    creator = ImageCreator.new(@cluebot)
    kit = IMGKit.new(creator.generate_html, quality: 50, width: 800, height: 600)
    kit.stylesheets << "css/styles.css"
    file = kit.to_file("tmp/file#{rand(1..100)}.jpg")
    file
  end
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
