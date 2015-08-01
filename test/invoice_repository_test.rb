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
end
