require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test
  def test_it_is_a_repository
    repo = TransactionRepository.new nil

    assert_kind_of Repository, repo
  end

  def test_it_is_created_by_engine
    engine = SalesEngine.new

    assert_kind_of TransactionRepository, engine.transaction_repository
  end

  def test_it_can_return_all_instances_as_array
    engine = SalesEngine.new

    assert_kind_of Hash, engine.transaction_repository.all
  end

  def test_can_return_all_instances
    engine = SalesEngine.new
    engine.startup

    assert_equal 5595, engine.transaction_repository.all.length
  end

  def test_can_return_random_instance
    engine = SalesEngine.new
    engine.startup
    repo = engine.transaction_repository

    instances = []
    100.times do
      instances << repo.random
    end

    refute instances.uniq.length == 1
  end

  def test_can_find_by_attribute
    engine = SalesEngine.new
    engine.startup
    repo = engine.transaction_repository

    assert_kind_of Transaction, repo.find_by(:invoice_id, 5)
  end

  def test_can_find_all_by_attribute
    engine = SalesEngine.new
    engine.startup
    repo = engine.transaction_repository

    assert_equal 4648, repo.find_all_by(:result, "success").length
  end

  def test_returns_empty_array_if_find_all_returns_nothing
    engine = SalesEngine.new
    engine.startup
    repo = engine.transaction_repository

    assert_equal [], repo.find_all_by(:credit_card_number, "1234567812345678")
  end

  def test_it_finds_by_credit_card_number
    engine = SalesEngine.new
    engine.startup
    transaction = engine.transaction_repository.find_by_credit_card_number "4634664005836219"
    assert_equal 5536, transaction.id
  end
end
