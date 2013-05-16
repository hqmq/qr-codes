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
  code = code.to_img.resize(400,400)

  #generate/annotate footer
  footer = ChunkyPNG::Image.new(400,100, ChunkyPNG::Color::WHITE)
  footer = MiniMagick::Image.read footer.to_blob
  footer.combine_options do |i|
    i.pointsize 40
    i.font 'Times-New-Roman-Bold'
    i.draw "text 125,60 '#{custid}'"
  end

  code = MiniMagick::Image.read code.to_blob
  complete = ChunkyPNG::Image.new(400,500, ChunkyPNG::Color::WHITE)
  complete = MiniMagick::Image.read complete.to_blob
  
  complete = complete.composite(code, 'png') do |c|
    c.compose 'Src-Over'
  end
  complete = complete.composite(footer, 'png') do |c|
    c.compose 'Src-Over'
    c.geometry '+0+400'
  end
  complete.write 'complete.png'
end
