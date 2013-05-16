require 'rake/testtask'
require 'bundler'
Bundler.setup

desc 'Run all unit tests'
Rake::TestTask.new('unit') do |t|
  t.pattern = "spec/unit/*_spec.rb"
end

desc 'Run all integration tests'
Rake::TestTask.new('integration') do |t|
  t.pattern = 'spec/integration/*_spec.rb'
end

desc 'generate a qr code image with human-readable text'
task :gen do
  company = 'evt'
  custid = "OX9B4"
  require 'rqrcode_png'
  require 'mini_magick'

  #generate qr code PNG
  code = RQRCode::QRCode.new( "#{company}:custid:#{custid}", :size => 4, :level => :h )
  png = code.to_img
  png.resize(400,400).save 'code.png'

  #generate/annotate footer
  img = ChunkyPNG::Image.new(400,100, ChunkyPNG::Color::WHITE)
  img.save 'bottom.png'
  img = MiniMagick::Image.open 'bottom.png'
  img.combine_options do |i|
    i.pointsize 40
    i.font 'Times-New-Roman-Bold'
    i.draw "text 125,60 '#{custid}'"
  end
  img.write 'bottom.png'

  img = ChunkyPNG::Image.new(400,500, ChunkyPNG::Color::WHITE)
  img.save 'complete.png'
  `composite -compose Src-Over code.png complete.png complete.png`
  `composite -compose Src-Over -geometry +0+400 bottom.png complete.png complete.png`
  File.unlink 'code.png'
  File.unlink 'bottom.png'
end
