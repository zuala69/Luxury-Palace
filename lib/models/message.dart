import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luxury_guide/models/user.dart';

class Message {
  late String id;
  late String text;
  late Timestamp sentAt;
  late String senderId;
  late String receiverId;
  late String chatterIds;
  late UserModel sender;
  late UserModel receiver;

  Message({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.senderId,
    required this.chatterIds,
    required this.receiverId,
    required this.sender,
    required this.receiver,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    sentAt = json['sentAt'];
    senderId = json['senderId'];
    chatterIds = json['chatterIds'];
    receiverId = json['receiverId'];
    sender = UserModel.fromJson(json['sender']);
    receiver = UserModel.fromJson(json['receiver']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "sentAt": sentAt,
      "senderId": senderId,
      "chatterIds": chatterIds,
      "receiverId": receiverId,
      "sender": sender.toJson(),
      "receiver": receiver.toJson(),
    };
  }
}
