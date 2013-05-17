require 'minitest/autorun'
require 'minitest/pride'

require 'rqrcode_png'
require 'zxing'
require 'tempfile'

describe 'Encode -> Decode' do
  it "works" do
    test_str = "evt:custid:AABCD"
    tmp = Tempfile.new(['qr','.png'])
    
    code = RQRCode::QRCode.new( test_str, :size => 4, :level => :h )
    code.to_img.resize(300,300).save tmp
    tmp.close

    decoded = ZXing.decode tmp.path
    decoded.must_equal test_str
  end

  it "works often" do
    test_strings = %w{ evt:custid:RVD6P evt:custid:L7WNT evt:custid:9DSKC evt:custid:D7RHB evt:custid:3VH75 evt:custid:4SPXL evt:custid:VH9K7 evt:custid:7X3RP evt:custid:9PWXC evt:custid:R7T83 }
    tempfiles = test_strings.map do |str|
      tmp = Tempfile.new(['qr', '.png'])

      code = RQRCode::QRCode.new( str, :size => 4, :level => :h )
      code.to_img.resize(400,400).save tmp
      tmp.close
      tmp
    end

    decoded_strings = tempfiles.map do |tmp|
      ZXing.decode tmp.path
    end

    decoded_strings.must_equal test_strings
  end
end
