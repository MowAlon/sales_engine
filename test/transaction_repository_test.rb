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
end
