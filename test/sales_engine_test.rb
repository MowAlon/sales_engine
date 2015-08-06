require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_converts_snake_to_camel
    snake = "hello_world"

    assert_equal "HelloWorld", engine.to_camel(snake)
  end
end
