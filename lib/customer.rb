require_relative 'data_instance'

class Customer < DataInstance
  attr_reader :first_name, :last_name

  def type_name
    :customer
  end

  def invoices
    all_referred_by sales_engine.invoice_repository
  end

  def transaction_ids
    transactions.map {|transaction| transaction.id}
  end

  def favorite_merchant
    hash = Hash.new(0)
    invoices.each {|invoice| hash[invoice.merchant_id] += 1}
    repo = repository.sales_engine.merchant_repository
    repo.find_by(:id, ranked_merchants(hash)[0][0])
  end

  def transactions
    invoices.map do |invoice|
      invoice.referred_by sales_engine.transaction_repository
    end
  end

  private

  def ranked_merchants(hash)
    hash.to_a.sort {|x, y| y[1] <=> x[1]}
  end

end
