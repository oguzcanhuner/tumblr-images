require 'sinatra'
require 'httparty'
require 'json'
require 'pry'

CONSUMER_KEY = "HOkdE4AtmCYUqthdKsJsSzlQH47n6UGwXqs5B5r838KMLwWt40"

get "/" do
  haml :index
end

get "/search/:term" do
  tumblr = Tumblr.new(key: CONSUMER_KEY)
  raw_result = tumblr.fetch_images(tag: params[:term], limit: 20)
  parsed_result = JSON.parse(raw_result.body)
  @images = []
  parsed_result["response"].each do |post|
    if post["photos"]
      image = post["photos"][0]["original_size"]
      @images << Image.new(image["url"], image["height"])
    end
  end

  haml :results
end

class Image
  def initialize(url, height)
    @url = url
    @height = height
  end

  attr_accessor :url, :height


end

class Tumblr
  include HTTParty
  base_uri "api.tumblr.com/v2"

  def initialize(options)
    @auth = options[:key]
  end

  def fetch_images(options={})
    options.merge!(api_key: @auth)
    self.class.get("/tagged", query: options)
  end
end
