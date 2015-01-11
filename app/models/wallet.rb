require 'coinkite'
class Wallet < ActiveRecord::Base
  belongs_to :user
  before_save :verify_wallet

  def verify_wallet
    ck = CoinKite.new(key, secret)
    
    if ck.check_permissions
      "Thanks"
    else
      raise
    end

  end

  def create_key_pairs
    #gernerating key pairs
    keypair = EncryptoSigno.generate_keypair
    private_key = keypair.to_s
    public_key  = keypair.public_key.to_s

    #signing of private key
    string = SecureRandom.base64
    signature = EncryptoSigno.sign(private_key, string)

    key = signature
    key_join = key.split.join
    key_by_2 = (key.split.join.size / 2)

    user1_key = key.split.join[0..key_by_2]
    user2_key = key.split.join[(key_by_2 + 1)..key_join.size]

    #after user is deseased a claim key is used to unlock account
    claim_key = user1_key + user2_key
    claim_key2 = user2_key + user1_key

    
  end

  # def destroy_key_pairs
  # end



end
