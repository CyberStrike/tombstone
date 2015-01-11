require 'coinkite'

class Wallet < ActiveRecord::Base

  belongs_to :user
  before_save :verify_wallet

  def verify_wallet
    ck = CoinKite.new(key, secret)

    if ck.permissions?
      self.errors.add(:form,'Wrong Key or Secret')
      false
    end

  end

  def create_key_pairs
    keypair = EncryptoSigno.generate_keypair
    private_key = keypair.to_s
    public_key  = keypair.public_key.to_s

    #signing of private key
    token = SecureRandom.base64
    signature = EncryptoSigno.sign(private_key, token)

    sig_join = signature.split.join
    signature_by_2 = (sig_join.size / 2)

    user1_key = sig_join[0..signature_by_2]
    user2_key = sig_join[(signature_by_2 + 1)..sig_join.size]
  end

  # def destroy_key_pairs
  # end


end
