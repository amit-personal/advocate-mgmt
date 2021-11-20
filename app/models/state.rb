class State < ApplicationRecord
	has_many :cases
	# has_many :advocates, through: :cases
	has_many :advocate_states
	has_many :advocates, through: :advocate_states
	
end
