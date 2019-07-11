require "application_system_test_case"

class GuestStoriesTest < ApplicationSystemTestCase
   test "I can see article index page" do
     visit articles_url
   end
end
