require_relative 'test_helper'

class RepositoryTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_
    skip
  end

end
