require_relative 'test_helper'

class DataInstanceTest < Minitest::Test
  def test_it_can_convert_symbol_to_instance_variable_name
    instance = DataInstance.new

    assert_equal :@hello, instance.to_instance_var(:hello)
  end
end
