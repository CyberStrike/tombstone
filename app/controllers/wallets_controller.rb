class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :edit, :update, :destroy]


  def index
    @wallets = Wallet.all
    @wallet = Wallet.new

  end

  def show
  end

  def new
    @wallet = Wallet.new
  end

  def edit
  end

  def create
    @wallet = Wallet.new(wallet_params)
    @wallet.user = current_user

    respond_to do |format|
      if @wallet.save
        format.html { redirect_to wallets_path, notice: 'Wallet was successfully created.' }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to wallets_path, notice: 'Wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @wallet.destroy
        format.html { redirect_to wallets_path, notice: 'Wallet was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    def wallet_params
      params.require(:wallet).permit(:key, :secret)
    end
end
