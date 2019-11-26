Rails.application.routes.draw do
  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id", to: "shelters#show"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#patch"
  # correct the delete path
  delete "/shelters/:id", to: "shelters#delete"
  get "/shelters/:id/pets", to: "shelters#pets"

  get "/shelters/:id/pets/new", to: "pets#new"
  post "/shelters/:id/pets", to: "pets#create"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#patch"
  delete "/pets/:id", to: "pets#delete"
end
