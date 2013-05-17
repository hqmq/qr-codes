require 'rqrcode_png'
require 'mini_magick'

class QrGen
  attr_reader :prefix, :data
  def initialize(prefix,data)
    @prefix, @data = prefix, data
  end

  def write(path, comment)
    composite_image(comment).write path
  end

  private
  def str
    @str ||= begin
      str = prefix+':'
      str = data.inject(str){ |str, pair| key,val = pair; str << "#{key}:#{val}" }
      str[0..150]
    end
  end

  def qr_image
    code = RQRCode::QRCode.new( str, :size => 4, :level => :h )
    code = code.to_img.resize(400,400)
    MiniMagick::Image.read code.to_blob
  end

  def comment_image(comment)
    footer = ChunkyPNG::Image.new(400,100, ChunkyPNG::Color::WHITE)
    footer = MiniMagick::Image.read footer.to_blob
    footer.combine_options do |i|
      i.pointsize 40
      i.font 'Times-New-Roman-Bold'
      i.draw "text 125,60 '#{comment}'"
    end
    footer
  end

  def composite_image(comment)
    complete = ChunkyPNG::Image.new(400,500, ChunkyPNG::Color::WHITE)
    complete = MiniMagick::Image.read complete.to_blob
    
    complete = complete.composite(qr_image, 'png') do |c|
      c.compose 'Src-Over'
    end
    complete = complete.composite(comment_image(comment), 'png') do |c|
      c.compose 'Src-Over'
      c.geometry '+0+400'
    end
    complete
  end
end
