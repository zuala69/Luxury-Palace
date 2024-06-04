import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';
import 'package:luxury_guide/models/message.dart';
import 'package:luxury_guide/models/user.dart';

import 'chat_tile.dart';
import 'input.dart';

class ChatsPage extends StatelessWidget {
  final UserModel chatUser;
  const ChatsPage({required this.chatUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatUser.name),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: StreamBuilder<QuerySnapshot<Message>>(
              stream: FirebaseController().to.getMessages(chatUser.id),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data == null) {
                    return Center(
                      child: Text(
                        "No account available to chat",
                        style: GoogleFonts.spectral(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  final items = snap.data?.docs ?? [];
                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                          "No Chats available now. Start by sending a message"),
                    );
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final msg = items[index].data();
                      return ChatTile(
                        prev: index > 0 ? (items[index - 1]).data() : null,
                        msg: msg,
                        index: index,
                      );
                    },
                  );
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: MessageInput(
              secondUser: chatUser,
            ),
          )
        ],
      ),
    );
  }
}
