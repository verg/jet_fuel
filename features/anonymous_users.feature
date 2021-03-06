Feature: Anonymous Users can use the site

  Scenario: Anonymous users can shorten URLs
    Given that I am an anonymous user of the system
    When I visit the site
    And give a URL to the service
    Then I expect it to return a service shortened URL

  Scenario: Shorten URLs redirect anonymous users to the original URL
    Given that I am an anonymous user of the system
    When I follow a service shortened URL
    Then I expect to be redirected to the original URL

  Scenario: Anonymous user visits the home page
    Given that I am an anonymous user of the system
    When There are multiple URLs with various popularity
    And I visit the site
    Then I expect to see URLs sorted by popularity
