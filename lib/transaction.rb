class Transaction
  attr_reader :transaction_repository, :id, :invoice_id, :credit_card_number
  attr_reader :credit_card_expiration_date, :result, :created, :updated

  def initialize(transaction, transaction_repository)
    @transaction_repository = transaction_repository
    @id = transaction[0]
    @invoice_id = transaction[1]
    @credit_card_number = transaction[2]
    @credit_card_expiration_date = transaction[3]
    @result = transaction[4]
    @created = transaction[5]
    @updated = transaction[6]
  end

  def invoice
    # returns an instance of Invoice associated with this object
    transaction_repository.sales_engine.invoice_repository.find_by(:id, invoice_id)
  end

end
