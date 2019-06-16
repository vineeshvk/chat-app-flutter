import 'package:chat_app/src/screens/users/model.dart';

class ChatListModel {
  final List<ChatModel> chats;
  ChatListModel({this.chats});

  factory ChatListModel.fromJson(List<dynamic> json) {
    var chats = json.map((chat) => ChatModel.fromJson(chat));
    return ChatListModel(chats: chats.toList() ?? []);
  }
}

class ChatModel {
  final String id;
  final String name;
  final String lastMessage;
  final List<UserModel> members;

  ChatModel({this.id, this.name, this.members, this.lastMessage});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    List jsonM = json['members'];
    var members = jsonM.map((member) => UserModel.fromJson(member));
    return ChatModel(
        id: json['id'],
        name: json['name'],
        members: members.toList(),
        lastMessage: json['lastMessage']);
  }
}
