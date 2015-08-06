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
  attr_reader :folder, :merchant_repository, :invoice_repository,
              :item_repository, :invoice_item_repository,
              :customer_repository, :transaction_repository

  def initialize(folder = nil)
    @folder = folder || default
    @merchant_repository = MerchantRepository.new(self)
    @invoice_repository = InvoiceRepository.new(self)
    @item_repository = ItemRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @customer_repository = CustomerRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
  end

  def default
    "../sales_engine/data"
  end

  def startup
    tables = %w[merchant invoice item invoice_item customer transaction]
    load_repositories(tables)
    transaction_repository.load_successful_transactions
  end

  def to_camel(input)
    input.split('_').map{|word| word.capitalize}.join
  end

  def load_repositories(tables)
   tables.each do |table|
      CSV.foreach("#{folder}/#{table}s.csv", :headers => true,
                                             :header_converters => :symbol,
                                             :converters => :numeric) do |row|
        hash = {}
        row.fields.length.times do |field|
          hash[row.headers[field]] = row.fields[field]
        end
        class_repo = eval(to_camel table).new(hash, eval("#{table}_repository"))
        eval("#{table}_repository").records[row[:id]] = class_repo
      end
    end
  end

end

engine = SalesEngine.new
engine.startup
