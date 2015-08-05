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
    if field == :id
      records[value]
    elsif records.values.any? { |element| element.respond_to?(field) }
      records.values.find do |element|
        element.send(field) == value
      end
    else
      raise ArgumentError, "Attempted to locate records by '#{field}', but that isn't a valid field for #{records[0].class} objects."
    end
  end

  def find_by_credit_card_number(value)
    find_by(:credit_card_number, value)
  end

  def find_by_id(value)
    find_by(:id, value)
  end

  def find_by_item_id(value)
    find_by(:item_id, value)
  end

  def find_by_name(value)
    find_by(:name, value)
  end

  def find_by_status(value)
    find_by(:status, value)
  end

  def find_by_unit_price(value)
    find_by(:unit_price, value)
  end

  def find_all_by(field, value)
    if records.values.any? { |element| element.respond_to?(field) }
      records.values.find_all do |element|
        element.send(field) == value
      end
    else
      raise ArgumentError, "Attempted to locate records by '#{field}', but that isn't a valid field for #{records[0].class} objects."
    end
  end

  def find_all_by_status(value)
    find_all_by(:status, value)
  end

  def find_all_by_name(value)
    find_all_by(:name, value)
  end

  def find_all_by_result(value)
    find_all_by(:result, value)
  end

  def find_all_by_quantity
    find_all_by(:quantity, value)
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
    ranked_sellers(hash, top_x_sellers).map do |seller, revenue|
      [seller, dollars(revenue)]
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

  def child_reference
    records[0].reference
  end
end
