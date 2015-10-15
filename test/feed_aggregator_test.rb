require '../main'
require 'rack/test'
require 'minitest/autorun'

ENV['RACK_ENV'] = 'test'

class FeedAggregatorTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_it_says_feed_aggregator
	  get '/'
	  assert last_response.ok?
	  assert_match 'Feed Aggregator', last_response.body
	end
end