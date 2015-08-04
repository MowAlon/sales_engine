require_relative 'test_helper'

class DataInstanceTest < Minitest::Test
  def test_it_can_convert_symbol_to_instance_variable_name
    instance = DataInstance.new Hash.new(:id => "1"), nil

    assert_equal :@hello, instance.to_instance_var(:hello)
  end

  def test_it_knows_the_name_of_the_type_it_exhibits
    customer = Customer.new Hash.new(:id => "1"), "hello"

    assert_equal :customer, customer.type_name
  end
end
