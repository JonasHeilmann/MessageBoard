class MessagesController < ApplicationController
  # Allows to respond to both html and json requests
  respond_to :html, :json

  # Check user authentication only for the routes that need it
  acts_as_token_authentication_handler_for User, except: [:index, :show], if: -> {request.format.json?}
  before_action :authenticate_user!, except: [:index, :show], unless: -> {request.format.json?} 

  # Finds message by id and makes it available as @message
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  # Get all messages
  def index
    @messages = Message.all.order("created_at DESC")
    respond_with(@messages)
  end

  # Sets a message that can be created
  def new
    @message = current_user.messages.build
    respond_with(@message)
  end

  def show
    respond_with(@message)
  end

  # Creates a new message based on the provided parameters message_params
  def create
    @message = current_user.messages.build(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to message_path(@message) }
        format.json { render json: { message: @message }, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: { errors: @message.errors }, status: :not_acceptable }
      end
    end 
  end

  def edit
    respond_with(@message)
  end

  # Updates the found message with the provided parameters message_params
  def update
    respond_to do |format|
      if @message.user_id == current_user.id
        if @message.update(message_params)
          format.html { redirect_to message_path }
          format.json { render json: { message: @message }, status: :accepted }
        else
          format.html { render 'edit' }
          format.json { render json: { errors: @message.errors }, status: :not_acceptable }
        end
      else
        format.html { 'show' }
        format.json { render json: {}, status: :unauthorized }
      end
    end 
  end

  # Destroys the found message and redirects to root
  def destroy
    if @message.user_id == current_user.id
      @message.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: {}, status: :no_content }
      end
    else 
      respond_to do |format|
        format.html { 'show' }
        format.json { render json: {}, status: :unauthorized }
      end
    end
  end

  private

    # Extracts params for a message and only permits a title and a description
    def message_params
      params.require(:message).permit(:title, :description)
    end

    # Finds a message by provided ID
    def find_message
      @message = Message.find(params[:id])
    end
end
