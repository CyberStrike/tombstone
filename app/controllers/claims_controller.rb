class ClaimsController < ApplicationController
	before_action :check_user, except: [:new]

	def index
		@claims = Claim.all
	end

	def new
		@claim = Claim.new
	end

	def create
		@claim = Claim.new(product_params)
			if @product.update(product_params)
	        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
	        format.json { render :show, status: :ok, location: @product }
	      else
	        format.html { render :edit }
	        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
	
end
