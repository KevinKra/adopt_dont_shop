Rails.application.routes.draw do
  root "pages#home"
  get "shelters", to: "pages#shelters"
end
