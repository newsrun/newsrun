require 'active_record'

class News < ActiveRecord::Base
	def all_fields 
		instance_variables.map { |v| instance_variable_get v  }
	end
end
