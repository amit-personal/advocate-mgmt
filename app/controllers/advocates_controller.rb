class AdvocatesController < ApplicationController
	def index
 		@advocates = Advocate.all
 	end

 	def new_senior
 		@user = User.new
 	end

 	def new_junior
 		@user = User.new
 		@all_seniors = Role.find_by_name('Senior')&.advocates
 	end

 	def senior_creation
 		begin
	 		@user = User.new(user_params)
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
	 		@user = User.new(user_params)
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
 		@states = State.all
 		@advocate = Advocate.all
 	end

 	def case_creation
 		if not check_if_rejected 
			flash[:alert] = "Case is rejected."
 			redirect_to new_case_path
 		else 
	 		begin
	 			@case = Case.new(case_params)
	 			if @case.save
	 				flash[:success] = "Case added"
	 				redirect_to root_path
				else
					@states = State.all
	 				@advocate = Advocate.all
	 				render 'new_case'
	 			end
	 		rescue StandardError => e
	 			@states = State.all
	 			@advocate = Advocate.all
	 			flash[:alert] = "Case is not created."
	 			render 'new_case'
	 		end
	 	end
 	end
 	def check_if_rejected
 		@case = Case.find_by_id(case_params[:id])
 		if @case.present?
 			Case.find_by_id(case_params[:id]).is_active
 		else 
 			true
 		end
 	end

	def new_state
		@advocate_state = AdvocateState.new
 		@states = State.all
 		@advocate = Advocate.all
 	end

 	def state_creation
 		begin
 			state = AdvocateState.new(advocate_state_params)
 			if state.save
 				flash[:success] = "State updated"
 				redirect_to root_path
			else
				@states = State.all
 				@advocate = Advocate.all
 				render 'new_state'
 			end
 		rescue StandardError => e
 			@states = State.all
 			@advocate = Advocate.all
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


end
