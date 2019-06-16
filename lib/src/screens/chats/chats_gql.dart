String getChatsQuery = """
query GetChats{
  getChats{
    id
    name
    lastMessage
    members{
      email
      id
    }
  }
}
""";
