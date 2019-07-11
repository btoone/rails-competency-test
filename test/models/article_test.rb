require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "has categories" do
    
    categories = Article.categories
    assert_not_nil categories
  end
end
