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

    # We should see some errors when trying to delete
    refute_empty article2.errors

    ## assertions for positive delete
    # assert_empty article2.errors
    # follow_redirect!
    # assert_response :success
    # assert_match /deleted/, flash.notice
  end

  test "can delete an article belonging to me" do
    count = Article.count
    article1 = articles :editor

    get article_path(article1)
    assert_response :success
    delete article_path(article1)

    ## assertions for positive delete
    assert_empty article1.errors
    follow_redirect!
    assert_response :success
    assert_match /deleted/, flash.notice
  end

  # test "can see the welcome page" do
  #   get "/"
  #   assert_select "h1", "Welcome#index"
  # end

  # test "can create an article" do
  #   get "/articles/new"
  #   assert_response :success

  #   post "/articles",
  #     params: { article: { title: "can create", body: "article successfully." } }

  #   assert_response :redirect
  #   follow_redirect!
  #   assert_response :success
  #   assert_select "p", "Title:\n can create"
  # end
end
