Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'advocates#index'

  get 'new_senior' => 'advocates#new_senior'
  get 'new_junior' => 'advocates#new_junior'
  get 'new_case' => 'advocates#new_case'
  get 'new_state' => 'advocates#new_state'
  get 'case_all' => 'advocates#case_all'
  put 'reject_case' => 'advocates#reject_case'
  post 'senior_creation' => 'advocates#senior_creation'
  post 'junior_creation' => 'advocates#junior_creation'
  post 'case_creation' => 'advocates#case_creation'
  post 'state_creation' => 'advocates#state_creation'
  # resources :advocates
   

end
