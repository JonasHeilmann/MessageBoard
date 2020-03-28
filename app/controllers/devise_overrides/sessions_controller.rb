class DeviseOverrides::SessionsController < Devise::SessionsController
  # Extended to also respond to json requests
  respond_to :html, :json
end