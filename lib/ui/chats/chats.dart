import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';
import 'package:luxury_guide/models/message.dart';
import 'package:luxury_guide/models/user.dart';
import 'package:luxury_guide/utils/colors.dart';
import 'chat_tile.dart';
import 'input.dart';

class ChatsPage extends StatelessWidget {
  final UserModel chatUser;
  const ChatsPage({required this.chatUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          chatUser.name,
          style: GoogleFonts.spectral(
            color: Colors.white,
          ),
        ),
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
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  final items = snap.data?.docs ?? [];
                  for (var element in items) {
                    log("Chat: ${element.data().text}");
                  }
                  if (items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Text(
                          "No Chats available now. Start by sending a message",
                          style: GoogleFonts.spectral(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: items.length,
                    padding: const EdgeInsets.symmetric(vertical: 25),
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
