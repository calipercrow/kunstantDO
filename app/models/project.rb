class Project < ActiveRecord::Base
	has_many :updates				# Calling 'POSTS' 'UPDATES', since it makes more sense 
end
