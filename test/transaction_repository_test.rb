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

    assert_kind_of Array, engine.transaction_repository.all
  end

  def test_can_return_all_instances
    engine = SalesEngine.new
    engine.startup

    assert_equal 1001, engine.transaction_repository.all.length
  end

end
