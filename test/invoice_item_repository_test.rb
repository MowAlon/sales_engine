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
end
