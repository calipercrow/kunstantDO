class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy] 
	# This is from randomscaffold! Lol... I GET IT! 
	# Above tells ruby to initialize this method first 'set_project' which adds the whole params thing ONLY to the specified.
	# Keeps shit DRY. Kno wha I'm sayin?


	# Controllers have actions! These are the 7 actions they can perform
	# Only 4 require VIEWS
	# mnemonic ---> I Sell New Cupcakes Eagerly Under Disguise 
	# All lowercase, notice how index is plural because it's a whole list!
	# Added a new method to protect people from abusing Mass Assignment --> "projects_params"

	def index									# Index is a list of things or ...basically your index page.
		@projects = Project.all					# Make a variable that can be seen by the view! with the @ - IT'S PLURAL!
	end

	def show									# Imagine list of items on a shopping site, info pulled from db
		#@project = Project.find(params[:id])	# Make a variable that can be seen in show view. Pass in :id (cuz of routes)
												# Take out because of the set_project before action! GENIUS!
	end
#----------------------------------------------------------------------
	# 1
	def new										# Takes user info on a form and then passes to Create
		@project = Project.new					# Make a var for new. Don't pass argument cuz we want it empty! Duh
	end

	# 2											# Doesn't need a view!
	def create									# Creates record in db and redirects (porbably to index)
		@project = Project.new(projects_params)	# Passes only title and desc.

    	respond_to do |format|					# All this is doing is rendering stuff in case of json
      		if @project.save
        		format.html { redirect_to @project, notice: 'Created a new project!' }
        		format.json { render :show, status: :created, location: @project }
      		else
        		format.html { render :new }
       			format.json { render json: @project.errors, status: :unprocessable_entity }
      		end
    	end
	end	
#----------------------------------------------------------------------
	# 1
	def edit									# Takes edit info in form, passes to Update (similar to previous set)
		#@project = Project.find(params[:id])	I believe this was taken out because of the form partial. No need to render this ?
	end

	# 2											# Doesn't need a view!
	def update									# Actually modifies the data and redirects (probably to index or show? depends)
		#@project = Project.find(params[:id])	# Taken out because of the before action GENIUS!

		respond_to do |format|
     		 if @project.update(projects_params)
        		format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        		format.json { render :show, status: :ok, location: @project }
      		else
        		format.html { render :edit }
        		format.json { render json: @project.errors, status: :unprocessable_entity }
      		end
    	end
	end
#----------------------------------------------------------------------
	def destroy									# Goes ahead and deletes the record / Doesn't need a view
		#@project = Project.find(params[:id])	# TAKEN OUT for bla bla bla
		@project.destroy

		respond_to do |format|
      		format.html { redirect_to projects_url, notice: 'EXTERMINATE!, EXTERMINATE!' }
      		format.json { head :no_content }
		end
	end
#------- PRIVATES UNDERNEATH!------------------------------------------

	private

	def set_project								# This method gets defined and then applied to show, edit, update and destroy on top
		@project = Project.find(params[:id])	# All this is doing finding its specific id
	end

	def projects_params							# This basically says you can only pass title/desc/default
		params.require(:project).permit(:title, :description, :default)			
	end

end
