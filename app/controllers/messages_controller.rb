class MessagesController < ApplicationController
  respond_to :json
  
  def index
    respond_with Message.find_or_create_default
  end
  def show
    respond_with Message.find(params[:id])
  end

  def create    
    
    respond_with Message.create(params[:message])
    begin
      Pusher['test_channel'].trigger!('an_event', {:some => 'data'})
    rescue Pusher::Error => e
      # (Pusher::AuthenticationError, Pusher::HTTPError, or Pusher::Error)
    end
  end

  def update
    message = Message.find(params[:id])
    message.update_attributes(params[:message])
    Pusher['test_channel'].trigger('updated', message.attributes, request.headers["X-Pusher-Socket-ID"])
    render :json => message
  end

  def destroy
    respond_with Message.destroy(params[:id])
  end
end
