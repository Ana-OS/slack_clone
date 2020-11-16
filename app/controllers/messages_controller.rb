class MessagesController < ApplicationController

  def create
      @chatroom = Chatroom.find(params[:chatroom_id])
      @message = Message.new(message_params)
      @message.chatroom = @chatroom
      @message.user = current_user

      if @message.save!
        # before redirecting I need to "broadcast" that message to the channel
        ChatroomChannel.broadcast_to(
          @chatroom, # this chatroom is the chatroom I'm streaming to in chatroom_channel
          render_to_string(partial: "message", locals: { message: @message })
            )


        redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
        #redirect to this saved message through anchor message.id. If message saved is at the bottom of the page it will redirect to the bottom. It works because I have - id="message-<%= message.id %>" in the chatrooms/show.html.erb
      else
        #rerender de chatrrom show page
        render 'chatrooms/show'
      end
  end

  private

  def message_params

    params.require(:message).permit(:content)
  end
end
