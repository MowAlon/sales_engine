require_relative 'test_helper'

class CustomerTest < Minitest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_invoices__it_returns_an_array_of_invoices
    customer = engine.customer_repository.find_by(:id, 21)

    assert_equal Array, customer.invoices.class
    assert customer.invoices.all?{|invoice| invoice.class == Invoice}
  end

  def test_invoices__it_returns_the_correct_invoices
    customer = engine.customer_repository.find_by(:id, 21)
    invoice_ids = customer.invoices.map {|invoice| invoice.id}
    merchant_ids = customer.invoices.map {|invoice| invoice.merchant_id}

    assert_equal ['109', '110', '111', '112', '113', '114', '115', '116'], invoice_ids
    assert_equal ['96', '45', '72', '71', '18', '44', '87', '80'], merchant_ids
  end

  def test_invoices__it_returns_an_empty_array_when_no_invoices_are_associated_with_the_customer
    skip
    customer = {:id => 1, :first_name => "Rurge", :last_name => "Hurms"}

    assert_equal [], customer.invoices
  end

  def test_it_finds_all_transactions_by_the_customer

  end

end
