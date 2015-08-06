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
    all_referred_by sales_engine.invoice_item_repository
  end

  def items
    item_ids = invoice_items.map {|invoice_item| invoice_item.item_id}.uniq
    item_ids.map {|item_id| repository.sales_engine.item_repository.find_by(:id, item_id)}
  end

  def customer
    refers_to sales_engine.customer_repository
  end

  def merchant
    repository.sales_engine.merchant_repository.find_by(:id, merchant_id)
  end

  def charge(*attributes)
    transaction_id = repository.sales_engine.transaction_repository.records.length + 1
    credit_card_number = attributes[0][:credit_card_number]
    credit_card_expiration_date = attributes[0][:credit_card_expiration]
    result = attributes[0][:result]
    attributes = {:id=>transaction_id, :invoice_id=> id,
                  :credit_card_number=> credit_card_number,
                  :credit_card_expiration_date=> credit_card_expiration_date,
                  :result=> result, :created_at=> Time.now.utc,
                  :updated_at=> Time.now.utc}
    repository.sales_engine.transaction_repository.records[transaction_id] = Transaction.new(attributes, repository.sales_engine.transaction_repository.records)
  end

end
