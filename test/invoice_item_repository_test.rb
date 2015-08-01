require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_is_a_repository
    invoice_item_repo = InvoiceItemRepository.new nil

    assert_kind_of Repository, invoice_item_repo
  end

  def test_it_is_created_by_engine
    engine = SalesEngine.new

    assert_kind_of InvoiceItemRepository, engine.invoice_item_repository
  end

  def test_it_can_return_all_instances_as_array
    engine = SalesEngine.new

    assert_kind_of Array, engine.invoice_item_repository.all
  end

  def test_can_return_all_instances
    engine = SalesEngine.new
    engine.startup

    assert engine.invoice_item_repository.all.length >= 1000
  end

  def test_can_return_random_instance
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_item_repository

    instances = []
    100.times do
      instances << repo.random
    end

    refute instances.uniq.length == 1
  end

  def test_can_find_by_invoice_id
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_item_repository

    assert_kind_of InvoiceItem, repo.find_by(:invoice_id, 2)
  end
end
