class TransactionRepository < Repository
  attr_reader :all_successful_transactions

  def load_successful_transactions
    @all_successful_transactions = sales_engine.transaction_repository.find_all_by(:result, "success")
  end

end
