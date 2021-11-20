class User < ApplicationRecord
	attr_accessor :senior_advocate
	has_one :advocate
	has_one :senior, foreign_key: "junior_id", class_name: "AdvocateMapping"
  has_many :juniors, foreign_key: "senior_id", class_name: "AdvocateMapping"
  has_many :cases, through: :advocate
end
