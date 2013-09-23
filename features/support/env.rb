require './jet_fuel'

require 'Capybara'
require 'Capybara/cucumber'
require 'rspec'

World do
  Capybara.app = JetFuel
end
