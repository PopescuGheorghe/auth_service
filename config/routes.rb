Rails.application.routes.draw do
  post '/authorize' => 'authorization#check_authorization'
  post 'generate_key' => 'authorization#create'
  delete 'delete_key/:id' => 'authorization#destroy'
  get 'current_user' => 'authorization#current_user'
end
