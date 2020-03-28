class DeviseOverrides::RegistrationsController < Devise::RegistrationsController
  # Extended to also respond to json requests
  respond_to :html, :json
end