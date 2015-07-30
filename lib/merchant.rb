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



  def revenue
    #revenue returns the total revenue for that merchant across all transactions
  end

  def revenue(date)
    #revenue(date) returns the total revenue for that merchant for a specific invoice date
  end

  def favorite_customer
    #favorite_customer returns the Customer who has conducted the most successful transactions
  end

  def customers_with_pending_invoices
    #customers_with_pending_invoices returns a collection of Customer instances which have pending (unpaid) invoices. An invoice is considered pending if none of it’s transactions are successful.
  end

# NOTE: Failed charges should never be counted in revenue totals or statistics.
# NOTE: All revenues should be reported as a BigDecimal object with two decimal places.




end
