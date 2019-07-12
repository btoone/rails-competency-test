require 'test_helper'

class EditorStoriesTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:bob)
  end

  test "can not delete an article belonging to someone else" do
    count = Article.count
    article1 = articles :editor
    article2 = articles :reporter

    get article_path(article2)
    assert_response :success
    delete article_path(article2)

    assert_match /denied/i, flash.notice
  end

  test "can delete ONLY articles that I created" do
    count = Article.count
    article1 = articles :editor

    get article_path(article1)
    assert_response :success
    delete article_path(article1)

    assert_empty article1.errors
    follow_redirect!
    assert_response :success
    assert_match /deleted/, flash.notice
  end

  test "can edit ONLY articles that I created" do
    skip
  end
end
