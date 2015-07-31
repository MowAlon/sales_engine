class MerchantRepository < Repository
  require 'bigdecimal'

  def most_revenue(top_x_sellers)
    hash = Hash.new(0)
    successful_transactions.each do |transaction|
      merchant = transaction_merchant(transaction)
      hash[merchant.name] += invoice_item_revenue(transaction)
    end
    top_sellers_by_revenue(hash, top_x_sellers).to_h
  end

  def most_items_sold(top_x_sellers)
    hash = Hash.new(0)
    successful_transactions.each do |transaction|
      merchant = transaction_merchant(transaction)
      hash[merchant.name] += invoice_item_items(transaction)
    end
    top_sellers_by_items(hash, top_x_sellers).to_h
  end

  def successful_transactions
    sales_engine.transaction_repository.find_all_by("result", "success")
  end

  def invoice(transaction)
    sales_engine.invoice_repository.find_by("id", transaction.invoice_id)
  end

  def invoice_items(transaction)
    sales_engine.invoice_item_repository.find_all_by("invoice_id", transaction.invoice_id)
  end

  def transaction_merchant(transaction)
    sales_engine.merchant_repository.find_by("id", invoice(transaction).merchant_id)
  end

  def invoice_item_revenue(transaction)
    sum = 0
    invoice_items(transaction).each do |invoice_item|
      sum += BigDecimal(invoice_item.quantity) * BigDecimal(invoice_item.unit_price)
    end
    sum
  end

  def invoice_item_items(transaction)
    sum = 0
    invoice_items(transaction).each do |invoice_item|
      sum += BigDecimal(invoice_item.unit_price)
    end
    sum
  end

  def top_sellers_by_revenue(hash, top_x_sellers)
    ranked_sellers(hash, top_x_sellers).map do |merchant, revenue|
      [merchant, dollars(revenue)]
    end
  end

  def top_sellers_by_items(hash, top_x_sellers)
    ranked_sellers(hash, top_x_sellers).map do |merchant, items|
      [merchant, items_sold(items)]
    end
  end

  def ranked_sellers(hash, top_x_sellers)
    sorted_hash(hash)[0..(top_x_sellers - 1)]
  end

  def sorted_hash(hash)
    hash.to_a.sort {|x, y| y[1] <=> x[1]}
  end

  def dollars(revenue)
    dollar_amount = revenue.to_i.to_s[0..-3].ljust(1, "0")
    cents_amount = revenue.to_i.to_s[-2..-1].rjust(2, "0")
    "Total revenue: $#{dollar_amount}.#{cents_amount}"
  end

  def items_sold(items)
    "Total items sold: #{items.to_i}"
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
