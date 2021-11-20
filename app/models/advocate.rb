class Advocate < ApplicationRecord
	belongs_to :user
	belongs_to :role
	has_many :cases
	# has_many :states, through: :cases
	has_many :advocate_states
	has_many :states, through: :advocate_states
end
