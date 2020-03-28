Rails.application.routes.draw do
  # Overwrite devise default routes to respond to json
  devise_for :users, :controllers => {
    sessions:  "devise_overrides/sessions",
    registrations: "devise_overrides/registrations"
  }

  # Add resources and REST api for messages
  resources :messages

  # Set root route to open messages index
  root 'messages#index'
end
