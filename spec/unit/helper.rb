require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'

module Fixture
  def fixture(basename)
    File.expand_path('../../fixtures/'+basename, __FILE__)
  end
end
