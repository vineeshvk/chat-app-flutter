import 'package:chat_app/src/screens/users/model.dart';

class MessageListModel {
  final String chatId;

  final List<MessageModel> messages;

  MessageListModel({this.chatId, this.messages});

  factory MessageListModel.fromJson(Map<String, dynamic> json) {
    List msg = json['messages'];
    var messages = msg.map((item) => MessageModel.fromJson(item));
    return MessageListModel(chatId: json['id'], messages: messages.toList());
  }
}

class MessageModel {
  final String id;
  final UserModel sender;
  final String text;
  final bool me;

  MessageModel({this.id, this.sender, this.text, this.me});

  factory MessageModel.fromJson(dynamic json) {
    UserModel sender = UserModel.fromJson(json['sender']);
    return MessageModel(
        id: json['id'], text: json['text'], me: json['me'], sender: sender);
  }
}
