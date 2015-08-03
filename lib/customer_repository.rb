class CustomerRepository < Repository
  def find_by_last_name value
    find_by(:last_name, value)
  end
end
