AngularUmpireAuditor::Application.routes.draw do
  
  root :to => 'home#index'

  scope :api do 
    get '/games/date/:year/:month/:day' => 'games#show'
    get '/worst_call' => 'home#worst_call'
    resources :umpires, only: [:index, :show]
  end


end
