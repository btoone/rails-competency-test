require "application_system_test_case"

class GuestStoriesTest < ApplicationSystemTestCase
   def setup
     @article = articles :one
   end

   test "I can see article index page" do
     visit articles_url
   end

   test "I can see a list of articles" do
     visit articles_url
     assert_selector "ul.articles"
     assert_content @article.title
   end
end
