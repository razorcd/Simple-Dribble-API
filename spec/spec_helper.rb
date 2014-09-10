

gem "minitest"
require "minitest/autorun"
require "vcr"
require "webmock/minitest"

require "./lib/dish.rb"

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end