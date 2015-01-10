
# Each request to the API requires three custom HTTP header fields:

# X-CK-Key

# This is your API Key, which is a GUID (random hex number) starting with K.

# X-CK-Sign

# This is the hex-encoded HMAC(SHA256) over specific values related to the request.
# The secret for the HMAC algorithm is is the API secret (which will start with K and be hex digits).

# X-CK-Timestamp

# An ISO 8601 format date and time. Should be UTC timezone and close to the correct time.
# Requests must provide strictly ascending values, which cannot be repeated.
# Either use a millisecond resolution, or limit your request rate to less than one per second.


class CoinKite
  require 'httparty'
  require 'time'

  include HTTParty

  base_uri 'https://api.coinkite.com'
  maintain_method_across_redirects true


  def initialize
  end

  def permissions

    endpoint = '/v1/my/self'

    build_headers(endpoint)

    self.class.get(endpoint)

  end

  def list_activity
    endpoint = '/v1/list/activity'
    build_headers(endpoint)

    self.class.get(endpoint)
  end

  def check_permissions
    permissions["api_key"]["permissions"].include? ("send" && "read" && "send2" && "xfer")
 end


  private

  API_KEY = 'K6638a8d7-e4587cb3-94a8672b9ede77a8'
  API_SECRET = 'Saa414d23-42e45f58-865ed630971a5295'

  def sign(endpoint)
    require 'cgi'
    require 'openssl'

    ts = Time.now.utc.iso8601
    data = endpoint + '|' + ts
    hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), API_SECRET, data)

    return hmac
  end

  def timestamp(force_ts=nil)
    Time.now.utc.iso8601
  end

  def build_headers(endpoint)

    self.class.headers({
     'X-CK-Key' => API_KEY,
     'X-CK-Sign' => sign(endpoint),
     'X-CK-Timestamp' => timestamp
     })
  end

end

ck = CoinKite.new
p ck.check_permissions