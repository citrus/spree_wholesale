Rails.application.routes.draw do
  
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
