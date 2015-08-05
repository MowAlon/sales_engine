require_relative 'test_helper'

class DataInstanceTest < Minitest::Test
  def test_it_can_convert_symbol_to_instance_variable_name
    instance = DataInstance.new Hash.new(:id => "1"), nil

    assert_equal :@hello, instance.to_instance_var(:hello)
  end

  def test_it_knows_the_name_of_the_type_it_exhibits
    customer = Customer.new Hash.new(:id => "1"), "hello"

    assert_equal :customer, customer.type_name
  end

  def test_it_knows_reference_name
    item = Item.new Hash.new(:id => "1"), nil

    assert_equal :item_id, item.reference
  end

  def test_can_ask_what_refers_to_it
    engine = SalesEngine.new
    engine.startup
    invoice = engine.invoice_repository.find_by(:id, "4")
    transaction = engine.transaction_repository.find_by(invoice.reference, invoice.id)

    assert_equal "3", transaction.id
  end

  def test_can_ask_what_refers_to_it_using_method
    engine = SalesEngine.new
    engine.startup
    invoice = engine.invoice_repository.find_by(:id, "4")
    transaction = invoice.referred_by(engine.transaction_repository)

    assert_equal "3", transaction.id
  end

  def test_all_referred_by_returns_array
    engine = SalesEngine.new
    engine.startup
    item = engine.item_repository.find_by(:id, "1")
    invoice_items = item.all_referred_by(engine.invoice_item_repository)

    assert_equal 3, invoice_items.length
    invoice_items.each do |invoice_item|
      assert_kind_of InvoiceItem, invoice_item
    end
  end

  def test_it_knows_repository
    engine = SalesEngine.new
    engine.startup
    customer = engine.customer_repository.find_by(:id, "10")

    assert_equal engine.customer_repository, customer.repository
  end

  def test_it_knows_engine
    engine = SalesEngine.new
    engine.startup
    invoice = engine.invoice_repository.find_by(:id, "14")

    assert_equal engine, invoice.sales_engine
  end
end
