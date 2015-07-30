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
  end

end
