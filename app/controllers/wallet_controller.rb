class WalletController < ApplicationController
  before_action :set_wallet, only: [:show, :edit, :update, :destroy]
  def index
    @wallets = Wallet.all
  end

  def show
    @wallet = Wallet.find_by(params(:id))
  end

  # GET /wallet/new
  def new
    @wallet = Wallet.new
  end

  # GET /wallet/1/edit
  def edit
  end

  # POST /wallet
  # POST /wallet.json
  def create
    @wallet = Wallet.new(wallet_params)

    respond_to do |format|
      if @wallet.save
        format.html { redirect_to @wallet, notice: 'Wallet was successfully created.' }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallet
  # PATCH/PUT /wallet.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to @wallet, notice: 'wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallet
  # DELETE /wallet.json
  def destroy
    @wallet.destroy
    respond_to do |format|
      format.html { redirect_to wallet_url, notice: 'Wallet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallet_params
      params.require(:wallet).permit(:secret, :key)
    end
end
