require_relative "image"
require_relative "nil_image"

class Post < Struct.new(:data)
  def post_url; data["post_url"]; end
  def date_published; data["date"]; end
  def type; data["type"]; end
  def photo?; type == "photo"; end

  def photos
    if photo?
      data["photos"].collect do |photo_data|
        Image.new(photo_data, self)
      end
    else
      NilImage.new
    end
  end
end
