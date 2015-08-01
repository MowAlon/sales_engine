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

  def test_most_revenue
    merchant_repo = MerchantRepository.new(engine)
    top_4 = 4

    expected = {"Okuneva, Prohaska and Rolfson"=>"Total items sold: 2383272",
      "Bechtelar, Jones and Stokes"=>"Total items sold: 2220166",
      "Dickinson-Klein"=>"Total items sold: 1421530",
      "Tromp Inc"=>"Total items sold: 1355112"}

    assert_equal expected, merchant_repo.most_items_sold(top_4)
  end

  def test_it_finds_total_revenue_by_date
    merchant_repo = MerchantRepository.new(engine)
    date = "2012-03-27"

    expected = "2012-03-27 Total revenue: $2612315.08"

    assert_equal expected, merchant_repo.revenue_by_date(date)
  end

end
