require_relative 'data_instance'

class Transaction < DataInstance
  attr_reader :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result

  def type_name
    :transaction
  end

  def invoice
    repository.sales_engine.invoice_repository.find_by(:id, invoice_id)
  end
end
