Rails.application.routes.draw do
  post '/check_and_move_file', to: 'files#check_and_move_file'


end
