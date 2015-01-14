class Claim < ActiveRecord::Base
  belongs_to :user
  has_many :wallets, through: :user
  before_save :verify_claim
  after_save :send_of_funds

  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/
  validates :upload, :attachment_presence => true

  # validates_attachment :avatar, :presence => true,
  # :content_type => { :content_type => "image/jpeg" },
  # :size => { :in => 0..7000.kilobytes }



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


  def closing_account

    send_of_funds

  end


  private
  def send_of_funds
    u=User.find(user_id).wallets.take
    ck = CoinKite.new(u.key, u.secret)
    next_step = ck.send_funds(0.0001, 0, btcaddy)
    ckref = next_step['result']['CK_refnum']
    authcode = next_step['result']['send_authcode']
    logger.debug ck.auth_send(ckref, authcode)
  end

end

