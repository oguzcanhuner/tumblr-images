require 'json'
require 'httparty'
require_relative 'post'

class Tumblr
  include HTTParty
  base_uri "api.tumblr.com/v2"

  def initialize(options)
    @auth = options[:key]
    @posts = []
  end

  attr_accessor :posts 

  def fetch_tagged_posts(options={})
    options.merge!(api_key: @auth)
    response = self.class.get("/tagged", query: options)
    response = JSON.parse(response.body)
    create_posts_from_response(response)
    return posts
  end

  def create_posts_from_response(response)
    response["response"].each do |post_data|
      add_post post_data
    end
  end

  def add_post(post_data)
    posts << Post.new(post_data)
  end
end
