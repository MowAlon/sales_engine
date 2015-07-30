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

  def test_all_returns_empty_array_by_default
    repo = Repository.new "panda"

    assert_equal [], repo.all
  end

  def test_random_returns_nothing_by_default
    repo = Repository.new "jeff"

    assert_nil repo.random
  end
end
