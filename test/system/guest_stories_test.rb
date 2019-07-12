require "application_system_test_case"

class GuestStoriesTest < ApplicationSystemTestCase
  def setup
    # not logged in
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

  test "I am sent to the signup page when I try to view an article show page" do
    visit articles_url
    click_on @article.title
    assert_no_content @article.content
    
    assert_equal new_user_registration_path, page.current_path
    assert_content "Sign up"
	end
end
