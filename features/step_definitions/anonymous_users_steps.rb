Given(/^that I am an anonymous user of the system$/) do
end

When(/^I visit the site$/) do
  visit '/'
end

When(/^give a URL to the service$/) do
  fill_in "uri_to_shorten", with: "http://example.com/page"
  click_button "Shorten URL"
end

Then(/^I expect it to return a service shortened URL$/) do
  shortened_urn = PersistedURI.all_short_urn.first
  expect(page).to have_link("#{current_url}#{shortened_urn}")
end

When(/^I follow a service shortened URL$/) do
  shortened_urn = PersistedURI.all_short_urn.first
  visit "/#{shortened_urn}"
end

Then(/^I expect to be redirected to the original URL$/) do
  expect(current_url).to eq "http://example.com/page"
end
