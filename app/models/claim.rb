class Claim < ActiveRecord::Base
	belongs_to :user
  before_save :verify_claim
  #validates :upload, :attachment_presence => true
  EmpAttachment.new(picture: open("#{Rails.root}/features/support/rails.png"))
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

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

