class Repository
  attr_reader :sales_engine, :records

  def initialize(sales_engine)
  	@sales_engine = sales_engine
    @records = []
  end

  def all
  	records
  end

  def random
    records.sample
  end

  def find_by(field, value)
    if records[0].respond_to?(field)
      records.find {|record| (record.send field).to_s.downcase == value.to_s.downcase}
    else
      raise ArgumentError, "Attempted to locate a record by '#{field}', but that isn't a valid field for #{records[0].class} objects."
    end
  end

  def find_all_by(field, value)
    if records[0].respond_to?(field)
      records.select {|record| (record.send field).to_s.downcase == value.to_s.downcase}
    else
      raise ArgumentError, "Attempted to locate records by '#{field}', but that isn't a valid field for #{records[0].class} objects."
    end
  end

  def successful_transactions
    sales_engine.transaction_repository.find_all_by("result", "success")
  end

  def invoice_item_revenue(transaction)
    sum = 0
    invoice_items(transaction).each do |invoice_item|
      sum += BigDecimal(invoice_item.quantity) * BigDecimal(invoice_item.unit_price)
    end
    sum
  end

  def dollars(revenue)
    dollar_amount = revenue.to_i.to_s[0..-3].ljust(1, "0")
    cents_amount = revenue.to_i.to_s.delete(revenue.to_i.to_s[0..-3]).rjust(2, "0")
    "$#{dollar_amount}.#{cents_amount}"
  end

  def invoice_items(transaction)
    sales_engine.invoice_item_repository.find_all_by("invoice_id", transaction.invoice_id)
  end

end
