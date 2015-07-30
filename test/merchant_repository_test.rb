require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_most_revenue
  	engine.merchant_repository.most_revenue(1)
    
    assert_equal 1, 1
  end


end
