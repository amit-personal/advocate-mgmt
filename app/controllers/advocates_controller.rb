class AdvocatesController < ApplicationController
	before_action :initialize_user, only: [:new_senior, :new_junior]
	before_action :define_user_params, only: [:senior_creation, :junior_creation]
	before_action :load_states_advocates, only: [:index, :new_case, :new_state]

	def index;end

 	def new_senior;end

 	def new_junior
 		@all_seniors = Role.find_by_name('Senior')&.advocates
 	end

 	def senior_creation
 		begin
	 		if @user.save 	
		 		advocate = @user.build_advocate(role_id: Role.find_by_name('Senior')&.id)
		 		advocate.save
 				flash[:success] = "Advocate added"
 				redirect_to root_path
		 	else
 				render 'new_senior'
 			end
 		rescue StandardError => e
 			flash[:alert] = "Advocate is not created."
 			render 'new_senior'
 		end
 	end

 	def junior_creation
 		begin
	 		if @user.save 	
		 		advocate = @user.build_advocate(role_id: Role.find_by_name('Junior')&.id)
		 		advocate.save	
		 		advocate_mapping = @user.build_senior(senior_id: params[:user][:senior_advocate])
		 		advocate_mapping.save
 				flash[:success] = "Advocate added"
 				redirect_to root_path
		 	else
 				render 'new_junior'
 			end
 		rescue StandardError => e
 			flash[:alert] = "Advocate is not created."
 			render 'new_junior'
 		end
 	end

 	def new_case
 		@case = Case.new
 	end

 	def case_creation
 		unless check_if_rejected 
			flash[:alert] = "Case is rejected."
 			redirect_to new_case_path
 		else 
	 		begin
	 			@case = Case.new(case_params)
	 			if @case.save
	 				flash[:success] = "Case added"
	 				redirect_to root_path
				else
					load_states_advocates
	 				render 'new_case'
	 			end
	 		rescue StandardError => e
				load_states_advocates
	 			flash[:alert] = "Case is not created."
	 			render 'new_case'
	 		end
	 	end
 	end
 	def check_if_rejected
 		case_data = Case.find_by_id(case_params[:id])
 		case_data.present? ? case_data.is_active : true
 	end

	def new_state
		@advocate_state = AdvocateState.new
 	end

 	def state_creation
 		begin
 			state = AdvocateState.new(advocate_state_params)
 			if state.save
 				flash[:success] = "State updated"
 				redirect_to root_path
			else
				load_states_advocates
 				render 'new_state'
 			end
 		rescue StandardError => e
			load_states_advocates
 			flash[:alert] = "State is not update."
 			render 'new_state'
 		end
 	end

 	def case_all
 		@cases = Case.all
 	end

 	def reject_case
 		Case.find_by_id(params[:id]).update(is_active: false)
 		redirect_to case_all_path
 	end

 	protected
 	def user_params
 		params.require(:user).permit(:id, :senior_advocate)
 	end
 	def case_params
 		params.require(:case).permit(:id, :state_id, :advocate_id)
 	end
 	def advocate_state_params
 		params.require(:advocate_state).permit(:state_id, :advocate_id)
 	end
			
	def initialize_user
		@user = User.new
	end

	def define_user_params
		@user = User.new(user_params)
	end

	def load_states_advocates
		@states = State.all
 		@advocates = Advocate.all
	end
end
