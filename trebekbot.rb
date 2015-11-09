require 'imgkit'
require 'json'
require 'marky_markov'

require_relative 'custom_twitter'
require_relative 'image_creator'

def get_catchphrase
  ## obviously unnecessary but heck, now it scales
  [
    "Please answer in the form of a question"
  ].shuffle.shift
end

def make_file
  creator = ImageCreator.new
  kit = IMGKit.new(creator.generate_html, quality: 50, width: 800, height: 600)
  kit.stylesheets << 'styles.css'
  kit.to_file("tmp/file#{rand(1..100)}.jpg")
end

def tweet
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

