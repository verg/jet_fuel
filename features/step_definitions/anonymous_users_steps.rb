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
  expect(page).to have_content(/#{current_url}rd\/\w+/)
end

When(/^I follow a service shortened URL$/) do
  original_uri = "example.com/page"
  short_urn = URIShortener.new.shorten(original_uri)
  PersistedURI.new(short_uri: short_urn, long_uri: original_uri).save
  visit "/rd/#{short_urn}"
end

Then(/^I expect to be redirected to the original URL$/) do
  follow_redirect!
  expect(last_response.url).to eq "www.example.com/url/1"
end
