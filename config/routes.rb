Rails.application.routes.draw do
  root 'home#show'
  resource 'home', controller: 'home', only: [:show]
  resource 'login', controller: 'login', only: [:show, :create]
  resource 'logout', controller: 'logout', only: [:show]
  resource 'registration', controller: 'registration', only: [:show, :create]
  resources 'servers', controller: 'servers', only: [:index, :show, :new, :destroy]
  resource 'charts', controller: 'charts', only: [:show]

  namespace 'api' do
    resources 'reports', controller: 'reports'
  end
end
