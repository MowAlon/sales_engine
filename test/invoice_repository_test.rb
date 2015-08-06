require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test
  def test_is_a_repository
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_kind_of Repository, repo
  end

  def test_it_returns_all_instances_as_an_array
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_kind_of Hash, repo.all
  end

  def test_it_can_return_all_instances
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_equal 4843, repo.all.length
  end

  def test_it_can_return_random_instance
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    instances = []
    100.times do
      instances << repo.random
    end

    refute_equal 1, instances.uniq.length
  end

  def test_can_find_by_attribute
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_equal 10, repo.find_by(:merchant_id, 92).customer_id
  end

  def test_can_find_all_by_attribute
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_equal 10, repo.find_all_by(:customer_id, 20).length
  end

  def test_returns_empty_array_if_find_all_returns_nothing
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_equal [], repo.find_all_by(:id, -5)
  end

  def test_it_creates_new_invoice
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository
    item1 = engine.item_repository.random
    item2 = engine.item_repository.random
    item3 = engine.item_repository.random
    customer = engine.customer_repository.random
    merchant = engine.merchant_repository.random
    invoice = repo.create(customer: customer, merchant: merchant,
                          status: "shipped", items: [item1, item2, item3])

    assert_equal merchant.id, invoice.merchant_id
    assert_equal customer.id, invoice.customer.id
    assert_equal 4844, invoice.id
  end
end
