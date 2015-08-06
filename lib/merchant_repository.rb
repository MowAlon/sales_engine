class MerchantRepository < Repository
  require 'bigdecimal'

  def most_revenue(top_x_sellers)
    merchants_with_revenue = Hash.new(0)
    successful_transactions.each do |transaction|
      merchant = transaction_merchant(transaction)
      merchants_with_revenue[merchant] += invoice_item_revenue(transaction)
    end
    top_sellers(merchants_with_revenue, top_x_sellers)
  end

  def most_items(top_x_sellers)
    merchants_with_items = Hash.new(0)
    successful_transactions.each do |transaction|
      merchant = transaction_merchant(transaction)
      merchants_with_items[merchant] += invoice_item_items(transaction)
    end
    top_sellers(merchants_with_items, top_x_sellers)
  end

  def revenue(date)
    gross = 0
    successful_transactions.each do |transaction|
      gross += invoice_item_revenue(transaction) if Date.parse(transaction.created_at) == date
    end
    gross
  end

  private

  def transaction_merchant(transaction)
    sales_engine.merchant_repository.find_by(:id, invoice(transaction).merchant_id)
  end

  def invoice_item_items(transaction)
    sum = 0
    invoice_items(transaction).each do |invoice_item|
      sum += BigDecimal(invoice_item.unit_price)
    end
    sum
  end
end
