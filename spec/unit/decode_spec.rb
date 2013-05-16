require_relative 'helper'
require 'zxing'

describe "QR Decoding" do
  include Fixture

  it "can decode from a png" do
    ['test_qr.png', 'test_qr_stretched.png', 'test_qr_screen.png'].each do |basename|
      decoded = ZXing.decode fixture(basename)
      decoded.must_equal 'evt:custid:AX09B'
    end
  end

  it "can decode from a JPEG" do
    decoded = ZXing.decode fixture('test_qr_screen.jpg')
    decoded.must_equal 'evt:custid:AX09B'
  end
end
