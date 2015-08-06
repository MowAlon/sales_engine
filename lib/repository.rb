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
    records.values.sample
  end

  def find_by(field, value)
    if field == :id
      records[value]
    elsif records.values.any? { |element| element.respond_to?(field) }
      records.values.find do |element|
        element.send(field) == value
      end
    else
      raise ArgumentError, "Attempted to locate records by '#{field}',
                            but that isn't a valid field for
                            #{records[0].class} objects."
    end
  end

  def find_by_credit_card_number(value)
    find_by(:credit_card_number, value.to_i)
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

  def find_by_unit_price(price)
    value = (price * 100).to_i
    find_by(:unit_price, value)
  end

  def find_all_by(field, value)
    if records.values.any? { |element| element.respond_to?(field) }
      records.values.find_all do |element|
        element.send(field) == value
      end
    else
      raise ArgumentError, "Attempted to locate records by '#{field}',
                            but that isn't a valid field for
                            #{records[0].class} objects."
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

  def find_all_by_quantity(value)
    find_all_by(:quantity, value)
  end

  def successful_transactions
    sales_engine.transaction_repository.all_successful_transactions
  end

  def invoice_item_revenue(transaction)
    sum = 0
    invoice_items(transaction).each do |invoice_item|
      quantity = BigDecimal(invoice_item.quantity)
      price = BigDecimal(invoice_item.unit_price)/100
      #price is stored in cents but we want to return dollars
      sum += quantity * price
    end if invoice_items(transaction)
    sum
  end

  def dollars(revenue)
    dollar_amount = revenue.to_i.to_s[0..-3].ljust(1, "0")
    whats_left = revenue.to_i.to_s.delete(revenue.to_i.to_s[0..-3])
    cents_amount = whats_left.rjust(2, "0")
    "$#{dollar_amount}.#{cents_amount}"
  end

  def invoice_items(transaction)
    repo = sales_engine.invoice_item_repository
    repo.find_all_by(:invoice_id, transaction.invoice_id) if transaction
  end

  def invoice(transaction)
    repo = sales_engine.invoice_repository
    repo.find_by(:id, transaction.invoice_id)
  end

  def top_sellers(hash, top_x_sellers)
    hash.max_by(top_x_sellers) {|seller, decimal_value| decimal_value}.to_h.keys
  end

  def child_reference
    records[1].reference
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
