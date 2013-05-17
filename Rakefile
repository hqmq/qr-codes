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
