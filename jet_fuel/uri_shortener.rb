require 'securerandom'

class URIShortener

  def initialize(opts={})
    @urn_generator = opts.fetch(:urn_generator) { default_rand_generator }
    @database = opts.fetch(:database) { PersistedURI }
  end

  def shorten(uri_to_shorten)
    begin
      short_urn = @urn_generator.call
    end while @database.find_by_urn(short_urn)

    short_urn
  end

  def default_rand_generator
    ->{ rand(10).to_s << SecureRandom.urlsafe_base64(4) }
  end
end
