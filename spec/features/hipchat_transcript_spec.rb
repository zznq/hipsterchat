require 'spec_helper'

#
# Given User goes to hipsterchat home page
# Then User sees the transcript from DevLab HipChat room
#

feature "Load Home Page" do
  scenario "User goes to home page" do
    visit root_url

    page.should have_content 'FoxPro'
    page.should have_content 'Jesse Flanning'
  end
end
