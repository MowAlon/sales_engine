class Customer
  attr_reader :customer_repository, :id, :first_name, :last_name, :created, :updated

  def initialize(customer, customer_repository)
    @customer_repository = customer_repository
    @id = customer[0]
    @first_name = customer[1]
    @last_name = customer[2]
    @created = customer[3]
    @updated = customer[4]
  end

  def invoices
    # returns a collection of Invoice instances associated with this object.
    customer_repository.sales_engine.invoice_repository.find_all_by(:customer_id, id)
  end




  def transactions
    # returns an array of Transaction instances associated with the customer
  end

  def favorite_merchant
    # returns an instance of Merchant where the customer has conducted the most successful transactions
  end

end
