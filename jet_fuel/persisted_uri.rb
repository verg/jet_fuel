require 'yaml/store'

class PersistedURI
  @@database ||= []

  def initialize(args)
    @short_uri = args.fetch(:short_uri)
    @long_uri = args.fetch(:long_uri)
  end

  def save
    uri = { short_uri: @short_uri, long_uri: @long_uri }
    @@database << uri
    uri
  end

  def self.find_by_uri(short_uri)
    @@database.select { |uri| uri[:short_uri] == short_uri }.first
  end

  def self.all
    @@database || []
  end

  def self.destroy_all
    @@database = []
  end
end
