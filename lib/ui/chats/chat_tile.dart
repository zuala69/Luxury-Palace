import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_guide/models/message.dart';
import 'package:luxury_guide/utils/functions.dart';

class ChatTile extends StatelessWidget {
  final Message? prev;
  final Message msg;
  final int index;
  const ChatTile({
    required this.prev,
    required this.msg,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSender = msg.senderId == uid();
    final tileColor = isSender ? Colors.blue[900]! : Colors.grey;
    return BubbleNormal(
      text: msg.text,
      isSender: isSender,
      color: tileColor,
      tail: true,
      textStyle: GoogleFonts.spectral(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
