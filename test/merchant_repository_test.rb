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

  def test_is_a_repository
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    assert_kind_of Repository, repo
  end

  def test_it_returns_all_instances_as_an_array
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    assert_kind_of Hash, repo.all
  end

  def test_it_can_return_all_instances
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    assert_equal 100, repo.all.length
  end

  def test_it_can_return_random_instance
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    instances = []
    100.times do
      instances << repo.random
    end

    refute_equal 1, instances.uniq.length
  end

  def test_can_find_by_attribute
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    assert_equal 5, repo.find_by(:name, "Williamson Group").id
  end

  def test_can_find_all_by_attribute
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    assert_equal 2, repo.find_all_by(:name, "Williamson Group").length
  end

  def test_returns_empty_array_if_find_all_returns_nothing
    engine = SalesEngine.new
    engine.startup
    repo = engine.merchant_repository

    assert_equal [], repo.find_all_by(:name, "Wonka Inc.")
  end

  def test_most_revenue
    merchant_repo = MerchantRepository.new(engine)
    top_3 = 3

    expected = "Kassulke, O'Hara and Quitzon"

    assert_equal expected, merchant_repo.most_revenue(top_3)[1].name
  end

  def test_most_tems_sold
    merchant_repo = MerchantRepository.new(engine)
    top_4 = 4

    expected = "Kassulke, O'Hara and Quitzon"

    assert_equal expected, merchant_repo.most_items(top_4)[1].name
  end

  def test_it_finds_total_revenue_by_date
    merchant_repo = MerchantRepository.new(engine)
    date = Date.new(2012, 3, 27)

    expected = BigDecimal.new('5749357487')

    assert_equal expected, merchant_repo.revenue(date)
  end

end
