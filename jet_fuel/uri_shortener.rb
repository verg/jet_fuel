require 'securerandom'

class URIShortener

  def initialize(opts={})
    @urn_generator = opts.fetch(:urn_generator) { ->{ SecureRandom.urlsafe_base64(5) } }
    @database = opts.fetch(:database) { PersistedURI }
  end

  def shorten(uri_to_shorten)
    begin
      short_urn = @urn_generator.call
    end while @database.find_by_urn(short_urn)

    short_urn
  end
end
