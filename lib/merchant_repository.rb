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

  def revenue_by_date(date)
    revenue = 0
    successful_transactions.each do |transaction|
      revenue += invoice_item_revenue(transaction) if transaction.created[0..9] == date
    end
    "#{date} Total revenue: #{dollars(revenue)}"
  end

  private

  def transaction_merchant(transaction)
    sales_engine.merchant_repository.find_by("id", invoice(transaction).merchant_id)
  end

  def invoice_item_items(transaction)
    sum = 0
    invoice_items(transaction).each do |invoice_item|
      sum += BigDecimal(invoice_item.unit_price)
    end
    sum
  end
end
