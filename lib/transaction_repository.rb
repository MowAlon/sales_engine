class TransactionRepository < Repository
  attr_reader :all_successful_transactions

  def load_successful_transactions
    repo = sales_engine.transaction_repository
    @all_successful_transactions = repo.find_all_by(:result, "success")
  end

end
