import 'package:luxury_guide/models/user.dart';

class Chat {
  late String id;
  late String lastMessage;
  late String lastMessageAt;
  late String lastMessageFromName;
  late UserModel userOne;
  late UserModel userTwo;

  Chat({
    required this.id,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.lastMessageFromName,
    required this.userOne,
    required this.userTwo,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastMessage = json['lastMessage'];
    lastMessageAt = json['lastMessageAt'];
    lastMessageFromName = json['lastMessageFromName'];
    userOne = UserModel.fromJson(json['userOne']);
    userTwo = UserModel.fromJson(json['userTwo']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "lastMessage": lastMessage,
      "lastMessageAt": lastMessageAt,
      "lastMessageFromName": lastMessageFromName,
      "userOne": userOne.toJson(),
      "userTwo": userTwo.toJson(),
    };
  }
}
