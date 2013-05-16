require 'minitest/autorun'
require 'minitest/pride'
require 'zxing'

describe "QR Decoding" do
  def fixture(basename)
    File.expand_path('../../fixtures/'+basename, __FILE__)
  end

  it "can decode qr codes from images" do
    ['test_qr.png', 'test_qr_stretched.png', 'test_qr_screen.png'].each do |basename|
      decoded =  ZXing.decode fixture(basename)
      decoded.must_equal 'evt:custid:AX09B'
    end
  end
end
