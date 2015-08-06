require_relative 'test_helper'
require_relative '../lib/repository'

class RepositoryTest < Minitest::Test
  def test_it_throws_error_without_argument
    assert_raises(ArgumentError) {
      repo = Repository.new
    }
  end

  def test_it_takes_string_as_argument
    repo = Repository.new "hello"

    assert_kind_of Repository, repo
  end

  def test_all_returns_empty_array_by_default
    repo = Repository.new "panda"

    assert_equal({}, repo.all)
  end

  def test_random_returns_nothing_by_default
    repo = Repository.new "jeff"

    assert_equal(nil, repo.random)
  end

  def test_find_by_throws_error_while_records_are_empty
    assert_raises(ArgumentError) {
      repo = Repository.new "sarah"
      repo.find_by "hello", nil
    }
  end

  def test_it_knows_engine
    engine = SalesEngine.new
    engine.startup
    repo = engine.customer_repository

    assert_equal engine, repo.sales_engine
  end

  def test_it_knows_child_reference
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository
    invoice = engine.invoice_repository.find_by(:id, 50)

    assert_equal repo.child_reference, invoice.reference
  end
end
