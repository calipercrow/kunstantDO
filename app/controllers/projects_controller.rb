class ProjectsController < ApplicationController

	# Controllers have actions! These are the 7 actions they can perform
	# Only 4 require VIEWS
	# I Sell New Cupcakes Eagerly Under Disguise 
	# All lowercase
	# Added a new method to protect people from abusing Mass Assignment --> "projects_params"

	def index									# Index is a list of things or ...basically your index page.
		@projects = Project.all					# Make a variable that can be seen by the view! with the @ - IT'S PLURAL!
	end

	def show									# Imagine list of items on a shopping site, info pulled from db
		@project = Project.find(params[:id])	# Make a variable that can be seen in show view. Pass in :id (cuz of routes)
	end
#-------
	# 1
	def new										# Takes user info on a form and then passes to Create
		@project = Project.new					# Make a var for new. Don't pass argument cuz we want it empty! Duh
	end

	def projects_params
		params.require(:project).permit(:title, :description, :default)			# This basically says you can only pass title and desc.
	end

	# 2											# Doesn't need a view!
	def create									# Creates record in db and redirects (porbably to index)
		@project = Project.new(projects_params)							# Passes only title and desc.

		if @project.save
			redirect_to projects_path, :notice => "Created a new project!"
		else
			render "new"
		end
	end	
#-------
	# 1
	def edit									# Takes edit info in form, passes to Update (similar to previous set)
		@project = Project.find(params[:id])
	end

	# 2											# Doesn't need a view!
	def update									# Actually modifies the data and redirects (probably to index or show? depends)
		@project = Project.find(params[:id])

		if @project.update_attributes(projects_params)
			redirect_to projects_path, :notice => "Your project was edited"
		else
			render "edit"
		end
	end
#-------
												# Doesn't need a view!
	def destroy									# Goes ahead and deletes the record
		@project = Project.find(params[:id])
		@project.destroy

		redirect_to projects_path, :notice => "Your project was eviscerated"
	end

end
