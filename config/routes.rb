Rails.application.routes.draw do
  
  root to: 'skipio#index'
  get '/message/:id', to: 'skipio#message', as: :message
  post '/send_message', to: 'skipio#send_message', as: :send_message
end
