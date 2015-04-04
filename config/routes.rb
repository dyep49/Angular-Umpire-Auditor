AngularUmpireAuditor::Application.routes.draw do
  
  root :to => 'home#index'

  scope :api do 
    get '/games/date/:year/:month/:day' => 'games#show'
    get '/worst_call' => 'home#worst_call'
    get '/days/dates' => 'days#dates'
    get '/umpires/year/:year' => 'umpires#show_year'
    resources :umpires, only: [:index, :show]
    resources :days, only: [:index]
    resources :teams, only: [:index, :show]
  end


end
