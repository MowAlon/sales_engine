require_relative 'data_instance'

class Merchant < DataInstance
  attr_reader :name

  def type_name
    :merchant
  end

  def items
    all_referred_by sales_engine.item_repository
  end

  def invoices
    all_referred_by sales_engine.invoice_repository
  end

  def total_revenue
    revenue = 0
    merchant_successful_transactions.each do |transaction|
      revenue += repository.invoice_item_revenue(transaction)
    end
    revenue
  end

  def merchant_successful_transactions
    invoices.map do |invoice|
      repository.successful_transactions.find {|t| t.invoice_id == invoice.id if t}
    end
  end

  def revenue(date = nil)
    if date.nil?
      total_revenue
    else
      calculate_revenue_on_date(date)
    end
  end

  def calculate_revenue_on_date(date)
    revenue = 0
    merchant_successful_transactions.each do |transaction|
      if transaction
        year = transaction.created_at[0..3].to_i
        month = transaction.created_at[5..6].to_i
        day = transaction.created_at[8..9].to_i
        created_date = Date.new(year, month, day)
        revenue += repository.invoice_item_revenue(transaction) if created_date == date
      end
    end
    revenue
  end

  def favorite_customer
    customer_transactions.max_by {|customer, transactions| transactions}[0]
  end

  def customer_transactions
    merchant_successful_transactions.each_with_object(Hash.new(0)) do |transaction, hash|
      invoice = invoices.find {|invoice| invoice.id == transaction.invoice_id}
      customer = repository.sales_engine.customer_repository.find_by(:id, invoice.customer_id )
      hash[customer] += 1
    end
  end

  def customers_with_pending_invoices
    #customers_with_pending_invoices returns a collection of Customer instances which have pending (unpaid) invoices. An invoice is considered pending if none of it’s transactions are successful.
    all_pending.map do |invoice|
      repository.sales_engine.customer_repository.find_by(:id, invoice.customer_id)
    end
  end

  def all_pending
    invoices.select do |invoice|
      invoice if no_successful_transactions?(invoice)
    end
  end

  def no_successful_transactions?(invoice)
    transactions = repository.sales_engine.transaction_repository.find_all_by(:invoice_id, invoice.id)
    transactions.none? {|transaction| transaction.result == "success"}
  end
end
