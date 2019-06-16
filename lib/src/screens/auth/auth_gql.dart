String signinMutation = """
mutation Login(\$email:String!, \$password:String!,\$fcmToken:String){
  login(email:\$email,password:\$password,fcmToken:\$fcmToken){
    error{
      message
    }
    id
    token
  }
}
""";

String signupMutation = """
mutation Register(\$email:String!, \$password:String!,\$name:String!,\$fcmToken:String){
  register(email:\$email,password:\$password,name:\$name,fcmToken:\$fcmToken){
    error{
      message
    }
    id
    token
  }
}
""";
