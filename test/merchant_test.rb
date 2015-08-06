require_relative 'test_helper'

class MerchantTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_items__it_returns_an_array_of_items
    merchant = engine.merchant_repository.find_by(:id, 11)

    assert_equal Array, merchant.items.class
    assert merchant.items.all?{|item| item.class == Item}
  end

  def test_items__it_returns_the_correct_items
    merchant = engine.merchant_repository.find_by(:id, 11)
    item_ids = merchant.items.map {|item| item.id}
    unit_prices = merchant.items.map {|item| item.unit_price}

    assert_equal [207, 208, 209], item_ids
    assert_equal [32427, 48543, 23092], unit_prices
  end

  def test_invoices__it_returns_an_array_of_invoices
    merchant = engine.merchant_repository.find_by(:id, 11)

    assert_equal Array, merchant.invoices.class
    assert merchant.invoices.all?{|invoice| invoice.class == Invoice}
  end

  def test_invoices__it_returns_the_correct_invoices
    merchant = engine.merchant_repository.find_by(:id, 77)
    invoice_ids = merchant.invoices.map {|invoice| invoice.id}
    customer_ids = merchant.invoices.map {|invoice| invoice.customer_id}

    assert_equal [146, 178, 406, 508, 763, 1106, 1137,
                  1214, 1219, 1595, 1896, 2095, 2106,
                  2181, 2207, 2335, 2511, 2652, 2783,
                  2812, 2990, 3141, 3146, 3480, 3570,
                  3573, 3653, 3760, 4020, 4025, 4308,
                  4331, 4400, 4524, 4529, 4573, 4610,
                  4693, 4803, 4815, 4827], invoice_ids

    assert_equal [28, 37, 84, 107, 149, 212, 218, 236,
                  237, 307, 372, 415, 416, 432, 437,
                  469, 510, 532, 556, 560, 601, 627,
                  630, 712, 725, 727, 744, 770, 815,
                  816, 877, 883, 897, 923, 923, 936,
                  948, 968, 992, 993, 996], customer_ids
  end

  def test_it_finds_total_revenue
    merchant = engine.merchant_repository.find_by(:id, 4)

    expected = BigDecimal.new('55805522')/100

    assert_equal expected, merchant.total_revenue
  end

  def test_it_finds_revenue_by_date
    date = Date.new(2012, 3, 27)
    merchant = engine.merchant_repository.find_by(:id, 4)

    expected = BigDecimal.new('55805522')/100

    assert_equal expected, merchant.revenue(date)
  end

  def test_it_finds_favorite_customer
    merchant = engine.merchant_repository.find_by(:id, 7)

    expected = "Emmerich"

    assert_equal expected, merchant.favorite_customer.last_name
  end

  def test_it_finds_customers_with_pending_invoices
    merchant = engine.merchant_repository.find_by(:id, 34)

    expected = "Shannon"

    assert_equal expected, merchant.customers_with_pending_invoices[1].first_name
  end

  def test_knows_own_type_name
    merchant = engine.merchant_repository.find_by(:id, 34)

    assert_equal :merchant, merchant.type_name
  end
end
