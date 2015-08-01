class Merchant
  attr_reader :merchant_repository, :id, :name, :created, :updated

  def initialize(merchant, merchant_repository)
    @merchant_repository = merchant_repository
    @id = merchant[0]
    @name = merchant[1]
    @created = merchant[2]
    @updated = merchant[3]
  end

  def items
    # returns a collection of Item instances associated with that merchant for the products they sell
    merchant_repository.sales_engine.item_repository.find_all_by(:merchant_id, id)
  end

  def invoices
    # returns a collection of Invoice instances associated with that merchant from their known orders
    merchant_repository.sales_engine.invoice_repository.find_all_by(:merchant_id, id)
  end

  def total_revenue
    revenue = 0
    #revenue returns the total revenue for that merchant across all transactions
    merchant_successful_transactions.each do |transaction|
      revenue += merchant_repository.invoice_item_revenue(transaction)
    end
    "#{name} Total revenue: #{merchant_repository.dollars(revenue)}"
  end

  def merchant_successful_transactions
    invoices.map do |invoice|
      merchant_repository.successful_transactions.find {|t| t.invoice_id == invoice.id}
    end
  end

  def revenue_on_date(date)
    revenue = calculate_revenue_on_date(date)
    "#{name} Total revenue on #{date}: #{merchant_repository.dollars(revenue)}"
  end

  def calculate_revenue_on_date(date)
    revenue = 0
    merchant_successful_transactions.each do |transaction|
      revenue += merchant_repository.invoice_item_revenue(transaction) if transaction.created[0..9] == date
    end
    revenue
  end

  def favorite_customer
    #favorite_customer returns the Customer who has conducted the most successful transactions
     ranked_customers = customer_transactions_hash.to_a.sort {|x,y| y[1] <=> x[1]}
     "Favorite customer name: #{ranked_customers[0][0].first_name} #{ranked_customers[0][0].last_name}, customer id: #{ranked_customers[0][0].id}, with #{ranked_customers[0][1]} successful transactions"
  end

  def customer_transactions_hash
    hash = Hash.new(0)
    merchant_successful_transactions.each do |transaction|
      invoice = invoices.find {|invoice| invoice.id == transaction.invoice.id}
      customer = merchant_repository.sales_engine.customer_repository.find_by(:id, invoice.customer_id )
      hash[customer] += 1
    end
    hash
  end

  def customers_with_pending_invoices
    #customers_with_pending_invoices returns a collection of Customer instances which have pending (unpaid) invoices. An invoice is considered pending if none of it’s transactions are successful.
  end

# NOTE: Failed charges should never be counted in revenue totals or statistics.
# NOTE: All revenues should be reported as a BigDecimal object with two decimal places.




end
