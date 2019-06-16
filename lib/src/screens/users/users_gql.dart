String getUserQuery = """
query GetUsers {
  getUsers{
 	  users{
      id
      email
      name
    }
    error{
      path
      message
    }
  }
}
""";

String createChatMutation = """
mutation CreateChat(\$membersId:[String]!,\$name:String){
  createChat(membersId:\$membersId,name:\$name){
    message
    path
  }
}
""";
