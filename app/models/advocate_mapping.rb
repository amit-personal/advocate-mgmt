class AdvocateMapping < ApplicationRecord
	belongs_to :senior, :class_name => 'User'
  	belongs_to :junior, :class_name => 'User'
end
