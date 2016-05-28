Rails.application.routes.draw do
  post '/authorize' => 'authorization#check_authorization'
  post 'generate_key' => 'authorization#create'
end
