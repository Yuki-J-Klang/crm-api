Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      post "launch", to:"files#launch"
    end
  end
end
