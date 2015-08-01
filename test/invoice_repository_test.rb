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

    assert_kind_of Array, repo.all
  end

  def test_it_can_return_all_instances
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_equal 1001, repo.all.length
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

    assert_equal "92", repo.find_by(:customer_id, 10).merchant_id
  end
end
