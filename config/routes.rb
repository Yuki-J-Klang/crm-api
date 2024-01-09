Rails.application.routes.draw do
  post 'launch_container', to: 'files#launch_container'
end
