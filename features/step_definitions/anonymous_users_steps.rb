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
  shortened_urn = PersistedURI.all.first.short_urn
  expect(page).to have_link("#{current_url}#{shortened_urn}")
end

When(/^I follow a service shortened URL$/) do
  shortened_urn = PersistedURI.all_short_urn.first
  visit "/#{shortened_urn}"
end

Then(/^I expect to be redirected to the original URL$/) do
  expect(current_url).to eq "http://example.com/page"
end

When(/^There are multiple URLs with various popularity$/) do
  visit '/'
  fill_in "uri_to_shorten", with: "http://example.com/other_page"
  click_button "Shorten URL"
  expect(PersistedURI.all.count).to be >= 2
end

Then(/^I expect to see URLs sorted by popularity$/) do
  uris_sorted_desc = PersistedURI.all.sort! { |uri| uri.click_count }.reverse
  most_popular = uris_sorted_desc.first.short_urn
  least_popular = uris_sorted_desc.last.short_urn
  page.body.should =~ (/#{most_popular}.*#{least_popular}/m)
end
