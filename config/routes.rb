Rails.application.routes.draw do
  post '/check_file_existence', to: 'files#check_file_existence'

  
end
