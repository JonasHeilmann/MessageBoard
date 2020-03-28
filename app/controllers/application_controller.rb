class ApplicationController < ActionController::Base
  # Migrates the DB before any action to allow in-memory db usage in the development environment
  if Rails.env.development?
    before_action :migrate_db
  end

  # Get messages before any action to show from any route on left-hand side
  before_action :get_messages
  
  # Allows to repond to json requests withough CSRF token authenticity
  protect_from_forgery unless: -> { request.format.json? }

  # Catches errors thrown due to missig parameters and forms a json with details on the issue
  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: e.message }, status: :bad_request
  end

  # Catches errors thrown due to records not found and forms a json with details on the issue
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  private

    # Migrates the DB before any action to allow in-memory db usage
    def migrate_db
      ActiveRecord::MigrationContext.new(Rails.root.join('db', 'migrate'), ActiveRecord::SchemaMigration).migrate
    end
    
    # Get all messages to be able to render at all time on left hand side
    def get_messages
      @messages = Message.all.order("created_at DESC")
    end
end
