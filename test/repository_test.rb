require_relative 'test_helper'
require_relative '../lib/repository'

class RepositoryTest < Minitest::Test
  def test_it_throws_error_without_argument
    assert_raises(ArgumentError) {
      repo = Repository.new
    }
  end

  def test_it_takes_string_as_argument
    repo = Repository.new "hello"

    assert_kind_of Repository, repo
  end
end
