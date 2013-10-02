require 'yaml/store'

class PersistedURI
  @@database ||= []

  attr_reader :short_urn

  def initialize(args)
    @short_urn = args.fetch(:short_urn)
    @long_uri = args.fetch(:long_uri)
  end

  def save
    @@database << self
    self
  end

  def self.find_by_urn(short_urn)
    @@database.select { |uri| uri.short_urn == short_urn }.first
  end

  def self.all_urn_suffix
    @@database.map { |uri| uri.short_urn } || []
  end

  def self.destroy_all
    @@database = []
  end
end
