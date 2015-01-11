class Claim < ActiveRecord::Base
	belongs_to :user
  before_save :verify_claim
  #validates :upload, :attachment_presence => true

  def verify_claim
    u = self.user
    signature = EncryptoSigno.sign(u.private_key, u.token)
    sig_join = signature.split.join

    claim_key = keyone + keytwo
    claim_key2 = keytwo + keyone

    if sig_join == claim_key
      EncryptoSigno.verify(u.public_key, claim_key, u.token)
      self.status = "Validated"
    elsif sig_join == claim_key2
      EncryptoSigno.verify(u.public_key, claim_key2, u.token)
      self.status = "Validated"
      "ok"
    else
      self.errors.add(:form, "Wrong keys" )
      return false
    end 
  end


end

