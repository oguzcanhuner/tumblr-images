class Image
  def initialize(photo_data, post)
    @photo_data = photo_data["alt_sizes"].first
    @post = post
  end
  attr_reader :post

  def url; @photo_data["url"]; end
  def width; @photo_data["width"]; end
  def height; @photo_data["height"]; end
end
