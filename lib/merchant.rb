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
      repository.successful_transactions.find do |transaction|
        transaction.invoice_id == invoice.id if transaction
      end
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
    gross = 0
    merchant_successful_transactions.each do |transaction|
      if transaction
        repo = repository.invoice_repository
        transaction_invoice = repo.find_by(:id, transaction.invoice_id)
        revenue = repository.invoice_item_revenue(transaction)
        year = transaction_invoice.created_at[0..3].to_i
        month = transaction_invoice.created_at[5..6].to_i
        day = transaction_invoice.created_at[8..9].to_i
        created_date = Date.new(year, month, day)
        gross += revenue if created_date == date
      end
    end
    gross
  end

  def favorite_customer
    customer_transactions.max_by {|customer, transactions| transactions}[0]
  end

  def customer_transactions
    transactions = merchant_successful_transactions
    repo = repository.sales_engine.customer_repository
    transactions.each_with_object(Hash.new(0)) do |transaction, hash|
      invoice = invoices.find {|invoice| invoice.id == transaction.invoice_id}
      customer = repo.find_by(:id, invoice.customer_id )
      hash[customer] += 1
    end
  end

  def customers_with_pending_invoices
    repo = repository.sales_engine.customer_repository
    all_pending.map do |invoice|
      repo.find_by(:id, invoice.customer_id)
    end
  end

  def all_pending
    invoices.select do |invoice|
      invoice if no_successful_transactions?(invoice)
    end
  end

  def no_successful_transactions?(invoice)
    repo = repository.sales_engine.transaction_repository
    transactions = repo.find_all_by(:invoice_id, invoice.id)
    transactions.none? {|transaction| transaction.result == "success"}
  end
end
