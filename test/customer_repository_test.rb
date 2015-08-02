require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  def test_it_is_a_repository
    repo = CustomerRepository.new nil

    assert_kind_of Repository, repo
  end

  def test_it_is_created_by_engine
    engine = SalesEngine.new

    assert_kind_of CustomerRepository, engine.customer_repository
  end
end
