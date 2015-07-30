require_relative 'test_helper'
require_relative '../lib/repository'

class RepositoryTest < Minitest::Test
  def test_it_throws_error_without_argument
    assert_raises(ArgumentError) {
      repo = Repository.new
    }
  end
end
