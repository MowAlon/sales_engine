require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test
  def test_is_a_repository
    engine = SalesEngine.new
    engine.startup
    repo = engine.invoice_repository

    assert_kind_of Repository, repo
  end
end
