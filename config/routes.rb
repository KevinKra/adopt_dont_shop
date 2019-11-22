Rails.application.routes.draw do
  get "/shelters", to: "shelters#index"
  get "/shelters/:id", to: "shelters#show"
end
