class Claim < ActiveRecord::Base
	belongs_to :user
  validates :upload, :attachment_presence => true

  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/

def validate_claim
  claim_key = user1_key + user2_key
  claim_key2 = user2_key + user1_key

  if sig_join == claim_key
    p "ok"
    p EncryptoSigno.verify(public_key, claim_key, token)
  elsif sig_join == claim_key2
    p "ok"
    p EncryptoSigno.verify(public_key, claim_key2, token)
  else
    p "retry"
  end 
end



end
