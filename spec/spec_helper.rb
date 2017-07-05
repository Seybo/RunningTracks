require 'simplecov'
SimpleCov.start

require 'factory_girl'
require 'pry'
require 'support/factory_girl'
require_relative '../lib/running_track.rb'

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
end
