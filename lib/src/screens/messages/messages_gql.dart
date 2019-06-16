String createMessageMutation = """
mutation createMessage(\$chatId: String!, \$text: String!){
  createMessage(chatId: \$chatId, text: \$text){
    path
    message
  }
}
""";

String getMessagesQuery = """
query getMessages(\$chatId: String!){
  getMessages(chatId: \$chatId){
    error{
      path
      message
    }
    chat{
      id
      messages{
        id
        sender{
          id
          name
          email
        }
        text
        me
      }
    }
  }
}
""";

String deleteChatMutation = """
mutation DeletChat(\$chatId: String){
  deleteChat(chatId: \$chatId){
    error{
      path
      message
    }
    id
  }
}
""";
