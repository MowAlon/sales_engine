class Item
  attr_reader :item_repository, :id, :name, :description, :unit_price, :merchant_id, :created, :updated

  def initialize(item, item_repository)
    @item_repository = item_repository
    @id = item[0]
    @name = item[1]
    @description = item[2]
    @unit_price = item[3]
    @merchant_id = item[4]
    @created = item[5]
    @updated = item[6]
  end

  def invoice_items
    # returns a collection of InvoiceItems associated with this object
    item_repository.sales_engine.invoice_item_repository.find_all_by(:item_id, id)
  end

  def merchant
    # returns an instance of Merchant associated with this object
    item_repository.sales_engine.merchant_repository.find_by(:id, merchant_id)
  end

  def best_day
    # returns the date with the most sales for the given item using the invoice date
    #find all invoice invoice_items
    #add quantity if transaction successful
    hash = Hash.new(0)
    invoice_items.each do |invoice_item|
      hash[invoice_item.created[0..9]] += invoice_item.quantity.to_i if transaction_successful?(invoice_item)
    end
    sales = hash.values.sort[-1]
    date = hash.key(sales)
    "best day for #{name} sales is #{date} with #{sales} units sold"
  end

  def transaction_successful?(invoice_item)
    item_transactions(invoice_item).any? {|transaction| transaction.result == "success"}
  end

  def invoice(invoice_item)
    item_repository.sales_engine.invoice_repository.find_by(:id, invoice_item.invoice_id)
  end

  def item_transactions(invoice_item)
    item_repository.sales_engine.transaction_repository.find_all_by(:invoice_id, invoice(invoice_item).id)
  end

end
