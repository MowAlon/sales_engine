require_relative 'data_instance'

class Invoice < DataInstance
  attr_reader :customer_id, :merchant_id, :status
  
  def type_name
    :invoice
  end

  def transactions
    all_referred_by sales_engine.transaction_repository
  end

  def invoice_items
    # returns a collection of associated InvoiceItem instances
    all_referred_by sales_engine.invoice_item_repository
  end

  def items
    # returns a collection of associated Items by way of InvoiceItem objects
    item_ids = invoice_items.map {|invoice_item| invoice_item.item_id}.uniq
    item_ids.map {|item_id| repository.sales_engine.item_repository.find_by(:id, item_id)}
  end

  def customer
    # returns an instance of Customer associated with this object
    refers_to sales_engine.customer_repository
  end

  def merchant
    # returns an instance of Merchant associated with this object
    repository.sales_engine.merchant_repository.find_by(:id, merchant_id)
  end

end
