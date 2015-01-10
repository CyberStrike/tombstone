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



end
