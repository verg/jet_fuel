require 'securerandom'

class URIShortener

  def initialize(short_domain_name, opts={})
    @short_domain_name = short_domain_name
    @urn_generator = opts.fetch(:urn_generator) { ->{ SecureRandom.urlsafe_base64(5) } }
    @shortened_urns = {}
  end

  def shorten(uri_to_shorten)

    short_urn = generate_uniq_urn
    @shortened_urns[short_urn] = uri_to_shorten

    short_uri = ""
    short_uri << @short_domain_name
    short_uri << '/'
    short_uri << short_urn
  end

  private

  def generate_uniq_urn
    begin
      short_urn = @urn_generator.call
    end while @shortened_urns.include?(short_urn)

    short_urn
  end

end
