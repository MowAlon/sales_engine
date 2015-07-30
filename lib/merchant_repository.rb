class MerchantRepository < Repository


  def most_revenue(x)
    # returns the top x merchant instances ranked by total revenue
        # group invoices by merchant
        # for each group of invoices, remove those whose transaction failed
        # of remaining invoices, get all invoice_items and sum their unit prices
        # ... then sort merchants descending by sums and return x merchants in collection

    invoices = invoice_items_by_invoice
    invoice_totals = totals_prices_by_invoice(invoices)
                  require 'pry';binding.pry
  end

  def invoice_items_by_invoice
    sales_engine.invoice_item_repository.all.group_by{|invoice_item| invoice_item.invoice_id}
  end

  def totals_prices_by_invoice(invoices)
    totals = {}
    invoices.each do |invoice_id, invoice_items|
      totals[invoice_id] = invoice_items.reduce(0) {|sum, invoice_item| sum + (invoice_item.quantity.to_i * invoice_item.unit_price.to_i)}
    end
    totals
  end









    #hash of merchant_ids holding invoice objects
    # successful_transactions = sales_engine.transaction_repository.find_all_by(:result, 'success')
    # successful_invoice_ids = successful_transactions.map {|transaction| transaction.invoice_id}.uniq
    #
    # invoice_items_by_invoice_id_hash = sales_engine.invoice_item_repository.all.group_by{|invoice_item| invoice_item.invoice_id}
    # successful_invoice_items_by_invoice_id_hash = invoice_items_by_invoice_id_hash.select{|invoice_id,invoice_item| successful_invoice_ids.include?(invoice_id)}
    # successful_invoice_items_by_invoice_id_hash.reduce{|sum, invoice_item| sum + (invoice_item.quantity * invoice_item.unit_price)}
    #
    #
    #
    #
    # sales_engine.invoice_repository.all.group_by{|invoice| invoice.merchant_id}

  def most_items(x)
    # returns the top x merchant instances ranked by total number of items sold
  end

  def revenue(date)
    # returns the total revenue for that date across all merchants
  end

end
