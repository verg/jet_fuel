require 'securerandom'

class URIShortener
  def initialize(short_domain_name, opts={})
    @short_domain_name = short_domain_name
    @urn_generator = opts.fetch(:urn_generator) { SecureRandom}
    @shortened_urns = {}
  end

  def shorten(uri_to_shorten)
    short_urn ||= @urn_generator.urlsafe_base64(5)
    @shortened_urns[short_urn] = uri_to_shorten
    short_uri = ""
    short_uri << @short_domain_name
    short_uri << '/'
    short_uri << short_urn
  end
end
