
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
  require 'cgi'
  include HTTParty

  attr_accessor :key, :secret

  base_uri 'https://api.coinkite.com'
  maintain_method_across_redirects true


  def initialize(key, secret)
    @key = key
    @secret = secret
  end


  ## Read

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

  def accounts
    endpoint = '/v1/my/accounts'

    build_headers(endpoint)

    self.class.get(endpoint)
  end

  ### Account Details
  def details(ckref)

    endpoint = '/v1/detail/'

    build_headers(endpoint)

    self.class.get(endpoint)
  end


  ## List


  ### Unauthorised Sends
  def unauth_sends

    endpoint = '/v1/list/unauth_sends'

    build_headers(endpoint)

    self.class.get(endpoint)
  end


  ## Update

  def auth_send(ckref, authcode)
    endpoint = '/v1/update/' + ckref + '/auth_send'

    build_headers(endpoint)

    self.class.put(endpoint, :body => {
        :authcode => authcode
    })
  end


  ## Send

  def send_funds(amount, acct, dest)


    endpoint = '/v1/new/send'
    build_headers(endpoint)

    self.class.put(endpoint,
     :body =>{
      :amount => amount,
      :account => acct,
      :dest => dest})
  end

  def permissions?
    if permissions["api_key"].nil? != true
      return (permissions["api_key"]["permissions"].include?("send" && "read" && "send2" && "xfer")) if permissions["api_key"].present?
    else
      return permissions["message"]
    end
  end

  private

  def sign(endpoint)
    require 'openssl'

    ts = Time.now.utc.iso8601
    data = endpoint + '|' + ts
    hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), @secret, data)

    return hmac
  end

  def timestamp(force_ts=nil)
    Time.now.utc.iso8601
  end

  def build_headers(endpoint)

    self.class.headers({
     'X-CK-Key' => @key,
     'X-CK-Sign' => sign(endpoint),
     'X-CK-Timestamp' => timestamp
     })
  end

end

#ck = CoinKite.new("K6638a8d7-e4587cb3-94a8672b9ede77a8","Saa414d23-42e45f58-865ed630971a5295")
#   ap ck.list_activity