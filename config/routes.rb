Rails.application.routes.draw do
  post 'distance', to: 'distances#create'
  get 'cost', to: 'distances#cost'
end
