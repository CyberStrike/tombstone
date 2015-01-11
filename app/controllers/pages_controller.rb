class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:inside, :create_keys]

  def home
  end
  
  def inside
  end

  def get_keys
  end


  def create_keys
    respond_to do |format|
      if current_user.create_key_pairs
        format.html { redirect_to keys_path, notice: 'Keys was successfully created.' }
      else
        format.html { redirect_to wallets_path, alert: 'Keys failed to be created.' }
      end
    end
  end

end
