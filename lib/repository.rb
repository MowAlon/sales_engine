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

end
