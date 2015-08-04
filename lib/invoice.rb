require_relative 'data_instance'

class Invoice < DataInstance
  attr_reader :customer_id, :merchant_id, :status
  
  def type_name
    :invoice
  end

  def transactions
    # returns a collection of associated Transaction instances
    repository.sales_engine.transaction_repository.find_all_by(:invoice_id, id)
  end

  def invoice_items
    # returns a collection of associated InvoiceItem instances
    repository.sales_engine.invoice_item_repository.find_all_by(:invoice_id, id)
  end

  def items
    # returns a collection of associated Items by way of InvoiceItem objects
    item_ids = invoice_items.map {|invoice_item| invoice_item.item_id}.uniq
    item_ids.map {|item_id| repository.sales_engine.item_repository.find_by(:id, item_id)}
  end

  def customer
    # returns an instance of Customer associated with this object
    repository.sales_engine.customer_repository.find_by(:id, customer_id)
  end

  def merchant
    # returns an instance of Merchant associated with this object
    repository.sales_engine.merchant_repository.find_by(:id, merchant_id)
  end

end
