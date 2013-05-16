require_relative 'helper'

require 'rqrcode_png'
require 'tempfile'

describe "QR Encoding" do
  it "generates an encoded image" do
    tempfile = Tempfile.new( ['qr','.png'] )
    code = RQRCode::QRCode.new( 'ff:custid:0X0XY', :size => 4, :level => :h )
    png = code.to_img
    png.resize(400,400).save tempfile
    assert (tempfile.size > 0)
  end
end
