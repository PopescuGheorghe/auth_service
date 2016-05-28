Rails.application.routes.draw do
  post '/authorize' => 'authorization#check_authorization'
end
