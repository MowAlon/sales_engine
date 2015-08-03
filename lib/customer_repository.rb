class CustomerRepository < Repository
  def find_by_last_name value
    find_by(:last_name, value)
  end

  def find_all_by_first_name value
    find_all_by(:first_name, value)
  end

  def invoices customer
    customer.invoices
  end
end
