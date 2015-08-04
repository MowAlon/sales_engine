require_relative 'data_instance'

class Transaction < DataInstance
  attr_reader :invoice_id, :credit_card_number
  attr_reader :credit_card_expiration_date, :result

  def initialize(transaction, repository)
    @repository = repository
    @id = transaction[:id]
    @invoice_id = transaction[:invoice_id]
    @credit_card_number = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result]
    @created = transaction[:created_at]
    @updated = transaction[:updated_at]
  end

  def invoice
    # returns an instance of Invoice associated with this object
    repository.sales_engine.invoice_repository.find_by(:id, invoice_id)
  end

end
