require_relative 'test_helper'

class ItemRepositoryTest < Minitest::Test
  attr_reader :engine, :repo

  def setup
    @engine = SalesEngine.new
    engine.startup
    @repo = engine.item_repository
  end

  def test_is_a_repository
    assert_kind_of Repository, repo
  end

  def test_it_returns_all_instances_as_an_array
    assert_kind_of Hash, repo.all
  end

  def test_it_can_return_all_instances
    assert_equal 1000, repo.all.length
  end

  def test_it_can_return_random_instance
    instances = []
    100.times do
      instances << repo.random
    end

    refute_equal 1, instances.uniq.length
  end

  def test_can_find_by_attribute
    assert_equal "Item Autem Minima", repo.find_by(:id, "2").name
  end

  def test_can_find_all_by_attribute
    assert_equal 2, repo.find_all_by(:unit_price, "75107").length
  end

  def test_returns_empty_array_if_find_all_returns_nothing
    assert_equal [], repo.find_all_by(:id, "-5")
  end

  def test_it_finds_items_with_most_revenue
    top_x_items = 3

    expected = {"206"=>"$281219.04", "227"=>"$244012.03", "584"=>"$136104.85"}

    assert_equal expected, repo.most_revenue(top_x_items)
  end

  def test_it_finds_most_sold_items
    top_x_items = 3

    expected = {"227"=>"Total items sold: 63",
                "206"=>"Total items sold: 48",
                "1978"=>"Total items sold: 44"}

    assert_equal expected, repo.most_items(top_x_items)
  end

end
