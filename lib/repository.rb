class Repository
  attr_reader :sales_engine, :records

  def initialize(sales_engine)
  	@sales_engine = sales_engine
    @records = {}
  end

  def all
  	records
  end

  def random
    records.to_a.sample(1).to_h
  end

  def find_by(field, value)
    if records.any? { |record| record[1].respond_to?(field) }
      found = []
      records.find do |record|
        found << record[1] if record[1].send(field) == value
      end
      found[0]
    else
      raise ArgumentError, "Attempted to locate records by '#{field}', but that isn't a valid field for #{records[0].class} objects."
    end
  end

  def find_all_by(field, value)
    if records.any? { |record| record[1].respond_to?(field) }
      found = []
      records.values.each do |element|
        found << element if element.send(field) == value
      end
      found
    else
      raise ArgumentError, "Attempted to locate records by '#{field}', but that isn't a valid field for #{records[0].class} objects."
    end
  end

  def successful_transactions
    sales_engine.transaction_repository.find_all_by(:result, "success")
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
    sales_engine.invoice_item_repository.find_all_by(:invoice_id, transaction.invoice_id)
  end

  def invoice(transaction)
    sales_engine.invoice_repository.find_by(:id, transaction.invoice_id)
  end

  def top_sellers_by_revenue(hash, top_x_sellers)
    ranked_sellers(hash, top_x_sellers).map do |merchant, revenue|
      [merchant, dollars(revenue)]
    end
  end

  def ranked_sellers(hash, top_x_sellers)
    sorted_hash(hash)[0..(top_x_sellers - 1)]
  end

  def sorted_hash(hash)
    hash.to_a.sort {|x, y| y[1] <=> x[1]}
  end

  def top_sellers_by_items(hash, top_x_sellers)
    ranked_sellers(hash, top_x_sellers).map do |seller, items|
      [seller, items_sold(items)]
    end
  end

  def items_sold(items)
    "Total items sold: #{items.to_i}"
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
