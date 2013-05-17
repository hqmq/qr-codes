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
  require_relative 'qr_gen'
  qr_gen = QrGen.new('evt', {'custid' => 'ABC123'})
  qr_gen.write('complete.png', 'ABC123')
end

desc 'generate a qr code for each person in a flat file'
task :summit, :flat_file, :output_dir do |t, args|
  require 'csv'
  require_relative 'qr_gen'
  CSV.foreach(args[:flat_file], headers: true, col_sep: "\t") do |row|
    first = row['first'].strip.downcase
    last = row['last'].strip.downcase
    gen = QrGen.new('evt', {'custid' => row['customer_id']})
    filepath = args[:output_dir] + "/#{first}_#{last}.png"
    puts "#{filepath} -> #{gen.str}"
    gen.write(filepath, row['customer_id'])
  end
end

desc 'decode a qr image'
task :decode, :dir do |t, args|
  require 'zxing'
  puts "decoding..."
  Dir[args[:dir]+'/*.png'].each do |png|
    decoded = ZXing.decode png
    puts "#{png} -> #{decoded}"
  end
end
