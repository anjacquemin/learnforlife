require "test_helper"

class CategoryProgressTest < ActiveSupport::TestCase
  def setup
    @categorie_progress_1 = category_progresses(:europe_progress_1)
  end

  test "category progress should be valid" do
    assert @categorie_progress_1.valid?, @categorie_progress_1.errors.messages
  end

  test "category progress should have a user" do
    @categorie_progress_1.user = nil
    assert_not @categorie_progress_1.valid?
  end

  test "category progress should have a category" do
    @categorie_progress_1.category = nil
    assert_not @categorie_progress_1.valid?
  end

  test "europe progress should have 1 theme : geography" do
    assert_equal @categorie_progress_1.theme.name, "geography"
  end

end
