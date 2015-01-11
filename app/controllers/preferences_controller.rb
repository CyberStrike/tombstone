class PreferencesController < ApplicationController

	before_action :set_preference, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate_user!

	def index
		@preferences = Preference.all
	end

	def new
		@preference = Preference.new
	end

	def edit
	end

	def show
		@preference = Preference.find_by(params[:id])
	end

	def create
		@preference = Preference.new(preference_params)
		
		respond_to do |format|
	      if @preference.save
	        format.html { redirect_to @claim, notice: 'Preference was successfully created.' }
	        format.json { render :show, status: :created, location: @preference }
	      else
	        format.html { render :new }
	        format.json { render json: @preference.errors, status: :unprocessable_entity }
	      end
    	end
  	end

    def update
     respond_to do |format|
	      if @preference.update(preference_params)
	        format.html { redirect_to @product, notice: 'Preference was successfully updated.' }
	        format.json { render :show, status: :ok, location: @claim }
	      else
	        format.html { render :edit }
	        format.json { render json: @preference.errors, status: :unprocessable_entity }
      	  end
        end
    end

    def destroy
    @preference.destroy
	    respond_to do |format|
	      format.html { redirect_to products_url, notice: 'Preference was successfully destroyed.' }
	      format.json { head :no_content }
	    end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @preference = Preference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:preference).permit(:altbtcaddy, :message, :user_id)
    end
	
end
