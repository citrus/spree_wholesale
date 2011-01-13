Rails.application.routes.draw do
  
  resources :wholesalers
  
  namespace(:admin) do
    resources :wholesalers
    resources :users do
      member do
        get :approve_wholesale
        get :reject_wholesale
      end
    end
  end

end
