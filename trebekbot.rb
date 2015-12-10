require 'imgkit'
require 'json'
require 'marky_markov'

require_relative 'config'
require_relative 'custom_twitter'
require_relative 'image_creator'
require_relative 'cluebot'

def get_catchphrase
  [
    "Please answer in the form of a question"
  ].shuffle.shift
end

def make_file
  puts "making file"
  creator = ImageCreator.new
  kit = IMGKit.new(creator.generate_html, quality: 50, width: 800, height: 600)
  kit.stylesheets << 'styles.css'
  file = kit.to_file("tmp/file#{rand(1..100)}.jpg")
  file
end

def tweet
  put "tweeting"
  file = make_file
  twit = CustomTwitter.new
  twit.update(get_catchphrase, file)
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
