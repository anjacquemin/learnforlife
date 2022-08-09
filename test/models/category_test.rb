require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @europe_capitales = categories(:europe_capitales)
  end

  test "europe_capitales should be valid" do
    assert @europe_capitales.valid?
  end

  test "europe_capitales should have a name" do
    @europe_capitales.name = ""
    assert_not @europe_capitales.valid?
  end

  test "europe_capitales should have 2 europe_capitales progress" do
    assert_equal @europe_capitales.category_progresses.count, 2
  end

  test "subtheme of category capitale europe should be europe" do
    assert_equal @europe_capitales.subtheme.name, "europe"
  end

  test "theme of category capitale should be geography" do
    assert_equal @europe_capitales.theme.name, "geography"
  end

end
