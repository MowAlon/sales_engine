require_relative 'data_instance'

class InvoiceItem < DataInstance
  attr_reader :repository, :item_id, :invoice_id, :quantity, :unit_price

  def initialize(invoice_item, repository)
    @repository = repository
    @id = invoice_item[0]
    @item_id = invoice_item[1]
    @invoice_id = invoice_item[2]
    @quantity = invoice_item[3]
    @unit_price = invoice_item[4]
    @created = invoice_item[5]
    @updated = invoice_item[6]
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
