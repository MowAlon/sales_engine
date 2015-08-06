class ItemRepository < Repository

  def most_revenue(top_x_items)
    hash = Hash.new(0)
    successful_transactions.each do |transaction|
      items_with_revenue(transaction, hash)
    end
    top_sellers(hash, top_x_items)
  end

  def most_items(top_x_items)
    hash = Hash.new(0)
    successful_transactions.each do |transaction|
      items_count(transaction, hash)
    end
    top_sellers(hash, top_x_items)
  end

  def items_with_revenue(transaction, hash)
    transaction_invoice_items(transaction).each do |invoice_item|
      revenue = invoice_item_revenue(transaction)
      hash[find_by(:id, invoice_item.item_id)] += revenue
    end
  end

  def items_count(transaction, hash)
    transaction_invoice_items(transaction).each do |invoice_item|
      hash[find_by(:id, invoice_item.item_id)] += invoice_item.quantity
    end
  end

  def transaction_invoice_items(transaction)
    repo = sales_engine.invoice_item_repository
    repo.find_all_by(:invoice_id, invoice(transaction).id)
  end

end
