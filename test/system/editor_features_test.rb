require "application_system_test_case"

class EditorFeaturesTest < ApplicationSystemTestCase
	include Devise::Test::IntegrationHelpers

  def setup
    # login as editor
    sign_in users(:bob)

    @article = articles :article_health_0
    @article2 = articles :article_superhero_2
  end

  test "I can see article index page" do
    visit articles_url
  end

  test "I can see a list of articles" do
    visit articles_url
    assert_selector "ul.articles"
    assert_content @article.title
  end

  test "I can see the homepage with first 3 articles from each category" do
    visit root_url

    assert_selector ".category"
    within("div#health-2") do
      assert_content @article.title
      assert_no_content @article2.title
      assert_selector "li", maximum: 3
    end
  end

  test "I can see article show pages" do
    visit articles_url
    click_on @article.title
    assert_content @article.content
  end

  test "I can create articles" do
    visit articles_url
    click_on "New Article"
    assert_content "Create an article"
    assert_content "Title"
    
    # Fill in form
    fill_in "Title", with: @article.title
    fill_in "Content", with: @article.content
    # select('Option', :from => 'Select Box')
    click_button "Create Article"

    assert_text "Article was created successfully"
  end

  test "I can delete an article" do
    count = Article.count
    article1 = articles :editor

    delete_an_article(article1)

    assert_text "Article was deleted successfully"
    assert_equal articles_path, page.current_path
    assert_equal count - 1, Article.count 
  end

  test "I can delete ONLY articles that I created" do
    count = Article.count
    article2 = articles :reporter

    # Try to delete an article created by another user
    visit list_articles_url
    click_on article2.title
    
    assert_no_selector "a", text: "Delete"
  end

  test "I can edit an article" do
    article1 = articles :editor
    visit list_articles_url
    click_on article1.title

    assert_selector "a", text: "Edit"
    click_on "Edit"
    click_button "Update Article"

    assert_text "Article was successfully updated"
  end

  test "I can edit ONLY articles that I created" do
    article2 = articles :editor2
    visit list_articles_url
    click_on article2.title

    assert_no_selector "a", text: "Edit"
  end

  def delete_an_article(article)
    visit list_articles_url
    click_on article.title
    page.accept_confirm do
      click_on "Delete", match: :first
    end
  end
end
