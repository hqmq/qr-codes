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
end
