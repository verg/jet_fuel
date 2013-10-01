Given(/^that I am an anonymous user of the system$/) do
end

When(/^I visit the site$/) do
  visit '/'
end

When(/^give a URL to the service$/) do
  fill_in "url", with: "www.example.com/url/1"
  click_button "Shorten URL"
end

Then(/^I expect it to return a service shortened URL$/) do
  expect(page).to have_content(/jet\.io\/\w+/)
end
