import consumer from "./consumer";
//consumer refers to the file consumer.js in this same folder

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;// this id will be the id we are using to instanciate Chatroom in the channels/chatroom_channel.rb

    //the line below is the one that ensures that the subscription is made and to which channel
    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) { // received is triggered only when new info arrives in the chatroomchannel
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data)
      },
    });
  }
}

export { initChatroomCable };
