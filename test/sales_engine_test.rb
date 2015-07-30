require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_
    skip
  end

end
