String deleteUserMutation = """
mutation DeleteUser{
  deleteUser
}
""";

String meQuery = """
query Me{
  me{
    id
    name
  }
}
""";

String renameUserMutation = """
mutation RenameUser(\$name: String){
  renameUser(name: \$name){
    error{
      path
      message
    }
    id
  }
}
""";
