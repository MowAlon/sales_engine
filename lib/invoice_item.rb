require_relative 'data_instance'

class InvoiceItem < DataInstance
  attr_reader :item_id, :invoice_id, :quantity, :unit_price

  def initialize(invoice_item, repository)
    @repository = repository
    @id = invoice_item[:id]
    @item_id = invoice_item[:item_id]
    @invoice_id = invoice_item[:invoice_id]
    @quantity = invoice_item[:quantity]
    @unit_price = invoice_item[:unit_price]
    @created = invoice_item[:created_at]
    @updated = invoice_item[:updated_at]
  end

  def invoice
    # returns an instance of Invoice associated with this object
    repository.sales_engine.invoice_repository.find_by(:id, invoice_id)
  end

  def item
    # returns an instance of Item associated with this object
    repository.sales_engine.item_repository.find_by(:id, item_id)
  end

  #untested
  def revenue
    quantity.to_i * unit_price.to_i
  end
end
