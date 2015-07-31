require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_it_exists
    merchant_repo = MerchantRepository.new(engine)

    assert merchant_repo
  end

  def test_most_revenue
    merchant_repo = MerchantRepository.new(engine)
    top_3 = 3

    expected = {"Okuneva, Prohaska and Rolfson"=>"Total revenue: $124181.26",
                "Bechtelar, Jones and Stokes"=>"Total revenue: $110898.05",
                "Tromp Inc"=>"Total revenue: $78824.63"}

    assert_equal expected, merchant_repo.most_revenue(top_3)
  end

end
