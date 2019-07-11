require "application_system_test_case"

class GuestStoriesTest < ApplicationSystemTestCase
   def setup
     @superhero_articles = Article.superhero
     @health_articles = Article.health

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

     assert_selector ".article-category"
     within("div#category-health-2") do
       assert_content @article.title
       assert_no_content @article2.title
       assert_selector "li", maximum: 3
     end
   end
end
