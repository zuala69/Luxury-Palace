import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';
import 'package:luxury_guide/models/message.dart';
import 'package:luxury_guide/models/user.dart';
import 'package:luxury_guide/utils/functions.dart';

import '../../controllers/user_controller.dart';

class MessageInput extends StatelessWidget {
  final UserModel secondUser;
  MessageInput({required this.secondUser, super.key});
  final txtCtrl = TextEditingController();
  final fcCtrl = FirebaseController().to;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: txtCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'Send a message',
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (txtCtrl.text.isNotEmpty) {
                final id = DateTime.now().millisecondsSinceEpoch.toString();
                final msg = Message(
                  id: id,
                  text: txtCtrl.text,
                  sentAt: Timestamp.now(),
                  senderId: uid()!,
                  chatterIds: combineUids(uid()!, secondUser.id),
                  receiverId: secondUser.id,
                  sender: UserController().to.user.value!,
                  receiver: secondUser,
                );
                FirebaseController().to.saveMessage(msg);
                txtCtrl.clear();
              }
            },
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }
}
