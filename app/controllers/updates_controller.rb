class UpdatesController < ApplicationController

	before_action :set_update, only: [:show, :edit, :update, :destroy] 
	
	def index									# Index is a list of things or ...basically your index page.
		@updates = Update.all					# Make a variable that can be seen by the view! with the @ - IT'S PLURAL!
	end

	def show
	end
#----------------------------------------------------------------------
	# 1
	def new										# Takes user info on a form and then passes to Create
		@update = Update.new					# Make a var for new. Don't pass argument cuz we want it empty! Duh
	end

	# 2											# Doesn't need a view!
	def create									# Creates record in db and redirects (porbably to index)
		@update = Update.new(updates_params)	# Passes only title and desc.

    	respond_to do |format|					# All this is doing is rendering stuff in case of json
      		if @update.save
        		format.html { redirect_to @update, notice: 'New update posted! w00t' }
        		format.json { render :show, status: :created, location: @update }
      		else
        		format.html { render :new }
       			format.json { render json: @update.errors, status: :unprocessable_entity }
      		end
    	end
	end	
#----------------------------------------------------------------------
	# 1
	def edit
	end

	# 2											# Doesn't need a view!
	def update		
		respond_to do |format|
     		 if @update.update(updates_params)
        		format.html { redirect_to @update, notice: 'Update modified, doctor.' }
        		format.json { render :show, status: :ok, location: @update }
      		else
        		format.html { render :edit }
        		format.json { render json: @update.errors, status: :unprocessable_entity }
      		end
    	end
	end
#----------------------------------------------------------------------
	def destroy			

		@update.destroy

		respond_to do |format|
      		format.html { redirect_to updates_url, notice: 'The update was put to sleep' }
      		format.json { head :no_content }
		end
	end
#------- PRIVATES UNDERNEATH!------------------------------------------

	private

	def set_update								# This method gets defined and then applied to show, edit, update and destroy on top
		@update = Update.find(params[:id])	# All this is doing finding its specific id
	end

	def updates_params							# This basically says you can only pass title/desc/default
		params.require(:update).permit(:text)			
	end



end
