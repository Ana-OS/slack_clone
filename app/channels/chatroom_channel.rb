class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "chatroom"
    chatroom = Chatroom.find(params[:id])#this id DOES NOT come from url
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
