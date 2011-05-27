Rails.application.routes.draw do
  
  resources :wholesalers
  
  namespace(:admin) do
    
    get '/wholesaler/states' => "wholesaler_states#index"
  
    resources :wholesalers do
      member do
        get :approve
        get :reject
      end
    end
    
  end

end
