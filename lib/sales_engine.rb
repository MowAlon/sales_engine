require 'csv'
require_relative 'repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'


class SalesEngine
  attr_reader :merchant_repository, :invoice_repository, :item_repository
  attr_reader :invoice_item_repository, :customer_repository, :transaction_repository

  def initialize(args=nil)
  	@merchant_repository = MerchantRepository.new(self)
    @invoice_repository = InvoiceRepository.new(self)
    @item_repository = ItemRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @customer_repository = CustomerRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
  end

  def startup
    tables = %w[merchant invoice item invoice_item customer transaction]
    load_repositories(tables)
  end

  def to_camel(input)
    input.split('_').map{|word| word.capitalize}.join
  end

  def load_repositories(tables)
  	tables.each do |table|
      CSV.foreach("../sales_engine/data/#{table}s.csv", :headers => true, :header_converters => :symbol) do |row|
        hash = {}
        row.fields.length.times do |field|
          hash[row.headers[field]] = row.fields[field]
        end
        eval("#{table}_repository").records << eval(to_camel table).new(hash, eval("#{table}_repository"), "#{table.to_sym}")
      end
    end
  end

end

engine = SalesEngine.new
engine.startup

# require 'pry'; binding.pry




# def startup
#   load_merchants('./data/merchants.csv')
#   load_invoices('./data/invoices.csv')
#   load_items('./data/items.csv')
#   load_invoice_items('./data/invoice_items.csv')
#   load_customers('./data/customers.csv')
#   load_transactions('./data/transactions.csv')
# end
#
# def load_merchants(file)
# 	CSV.foreach(file) {|row| merchant_repository.records << Merchant.new(row, merchant_repository)}
# end
#
# def load_invoices(file)
#   CSV.foreach(file) {|row| invoice_repository.records << Invoice.new(row, invoice_repository)}
# end
#
# def load_items(file)
#   CSV.foreach(file) {|row| item_repository.records << Item.new(row, item_repository)}
# end
#
# def load_invoice_items(file)
#   CSV.foreach(file) {|row| invoice_item_repository.records << InvoiceItem.new(row, invoice_item_repository)}
# end
#
# def load_customers(file)
#   CSV.foreach(file) {|row| customer_repository.records << Customer.new(row, customer_repository)}
# end
#
# def load_transactions(file)
#   CSV.foreach(file) {|row| transaction_repository.records << Transaction.new(row, transaction_repository)}
# end
