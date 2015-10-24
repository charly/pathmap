require File.expand_path("../../lib/pathmap", __FILE__)

require "minitest/autorun"
require "minitest/reporters"
require "pry"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

Pathmap.data_path= "test/data"

class Minitest::Test
  extend Minitest::Spec::DSL
end
