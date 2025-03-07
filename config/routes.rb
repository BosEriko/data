Rails.application.routes.draw do
  root to: redirect("https://cms.boseriko.com/")
  post "/", to: "graphql#execute"
end
