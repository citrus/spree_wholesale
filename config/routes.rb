Rails.application.routes.draw do

  get '/wholesaler/states' => "wholesaler_states#index"
    
  resources :wholesalers
  
  namespace(:admin) do
  
    resources :wholesalers do
      member do
        get :approve
        get :reject
      end
    end
    
  end

end
