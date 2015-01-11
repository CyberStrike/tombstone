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


end
