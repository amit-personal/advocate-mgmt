class Role < ApplicationRecord
	has_many :advocates
	has_many :users, through: :advocates
end
