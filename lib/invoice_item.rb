require_relative 'data_instance'

class InvoiceItem < DataInstance
  attr_reader :item_id, :invoice_id, :quantity, :unit_price

  def type_name
    :invoice_item
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
