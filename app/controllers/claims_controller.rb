class ClaimsController < ApplicationController
	before_action :set_claim, only: [:show, :edit, :update, :destroy]
	# before_action :authenticate_user!

	def index
		@claims = Claim.all
	end

	def new
		@claim = Claim.new
	end

	def edit
	end

	def show
	end

	def create
		@claim = Claim.new(claim_params)

		respond_to do |format|
	      if @claim.save
	        format.html { redirect_to @claim, notice: 'Claim was successfully created.' }
	        format.json { render :show, status: :created, location: @claim }
	      else
	        format.html { render :new }
	        format.json { render json: @product.errors, status: :unprocessable_entity }
	      end
    	end
	end

    def update
     respond_to do |format|
	      if @claim.update(claim_params)
	        format.html { redirect_to @product, notice: 'Claim was successfully updated.' }
	        format.json { render :show, status: :ok, location: @claim }
	      else
	        format.html { render :edit }
	        format.json { render json: @product.errors, status: :unprocessable_entity }
      	  end
        end
    end

    def destroy
    @claim.destroy
	    respond_to do |format|
	      format.html { redirect_to products_url, notice: 'Claim was successfully destroyed.' }
	      format.json { head :no_content }
	    end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:email, :status, :keyone, :keytwo, :btcaddy)
    end
	
end
