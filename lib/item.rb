require 'date'
require_relative 'data_instance'

class Item < DataInstance
  attr_reader :name, :description, :unit_price, :merchant_id

  def type_name
    :item
  end

  def invoice_items
    all_referred_by sales_engine.invoice_item_repository
  end

  def merchant
    # returns an instance of Merchant associated with this object
    repository.sales_engine.merchant_repository.find_by(:id, merchant_id)
  end

  def best_day
    # returns the date with the most sales for the given item using the invoice date
    #find all invoice invoice_items
    #add quantity if transaction successful
    hash = Hash.new(0)
    invoice_items.each do |invoice_item|
      hash[invoice_item.created_at[0..9]] += invoice_item.quantity.to_i #if transaction_successful?(invoice_item)
    end
    sales = hash.values.sort[-1]
    date = hash.key(sales)
    year = date[0..3].to_i
    month = date[5..6].to_i
    day = date[8..9].to_i
    Date.new(year, month, day)
  end

  def transaction_successful?(invoice_item)
    item_transactions(invoice_item).any? {|transaction| transaction.result == "success"}
  end

  def invoice(invoice_item)
    repository.sales_engine.invoice_repository.find_by(:id, invoice_item.invoice_id)
  end

  def item_transactions(invoice_item)
    repository.sales_engine.transaction_repository.find_all_by(:invoice_id, invoice(invoice_item).id)
  end
end
