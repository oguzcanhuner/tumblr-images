require 'sinatra'
require 'pry'
require_relative 'lib/tumblr'

CONSUMER_KEY = "HOkdE4AtmCYUqthdKsJsSzlQH47n6UGwXqs5B5r838KMLwWt40"

get "/" do
  if params[:term].nil? || params[:term].empty?
    @images = []
  else
    tumblr = Tumblr.new(key: CONSUMER_KEY)
    posts = tumblr.fetch_tagged_posts(tag: params[:term], limit: 20)
    @images = posts.collect(&:photos).flatten
  end

  haml :index
end
