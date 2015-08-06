class InvoiceRepository < Repository

  def create(*invoice_attributes)
    repo = sales_engine.invoice_repository
    customer_id = invoice_attributes[0][:customer].id
    merchant_id = invoice_attributes[0][:merchant].id
    status = invoice_attributes[0][status]
    attributes = {:id=>records.length + 1, :customer_id=> customer_id,
                  :merchant_id=>merchant_id, :status=> status,
                  :created_at=>Time.now.utc, :updated_at=>Time.now.utc}
    @records[records.length + 1] = Invoice.new(attributes, repo)
  end

end
