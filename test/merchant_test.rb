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

    assert_equal ['207', '208', '209'], item_ids
    assert_equal ['32427', '48543', '23092'], unit_prices
  end

  def test_items__it_returns_an_empty_array_when_no_items_are_associated_with_the_merchant
    merchant = engine.merchant_repository.find_by(:id, 50)

    assert_equal [], merchant.items
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

    assert_equal ['146', '178', '406', '508', '763'], invoice_ids
    assert_equal ['28', '37', '84', '107', '149'], customer_ids
  end

  def test_invoices__it_returns_an_empty_array_when_no_invoices_are_associated_with_the_merchant
    merchant = engine.merchant_repository.find_by(:id, 101)

    assert_equal [], merchant.invoices
  end

end
