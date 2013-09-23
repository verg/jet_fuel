Feature: Anonymous Users can use the site

  Scenario: Anonymous users can shorten URLs
    Given that I am an anonymous user of the system
    When I visit the site
    And give a URL to the service
    Then I expect it to return a service shortened URL
