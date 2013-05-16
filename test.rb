require 'zxing'
['test_qr.png', 'test_qr_stretched.png', 'test_qr_screen.png'].each do |basename|
  decoded =  ZXing.decode(File.expand_path(basename))
  puts "#{basename} => #{decoded}"
end
