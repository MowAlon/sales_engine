class ItemRepository < Repository

  def most_revenue(top_x_items)
    # returns the top x item instances ranked by total revenue generated
    hash = Hash.new(0)
    successful_transactions.each do |transaction|
      transaction_invoice_items(transaction).each do |invoice_item|
        hash[invoice_item.item_id] += invoice_item_revenue(transaction)
      end
    end
    top_sellers_by_revenue(hash, top_x_items).to_h
  end

  def transaction_invoice_items(transaction)
    sales_engine.invoice_item_repository.find_all_by(:invoice_id, invoice(transaction).id)
  end

  def most_items(x)
    # returns the top x item instances ranked by total number sold
  end

end
