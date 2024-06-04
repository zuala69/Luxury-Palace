import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';
import 'package:luxury_guide/utils/strings.dart';

import '../chats/chats.dart';
import '../profile/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfilePage());
            },
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseController().to.getUsers(),
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data?.docs.isEmpty ?? true) {
              return Center(
                child: Text(
                  "No account available to chat",
                  style: GoogleFonts.spectral(
                    fontSize: 20,
                  ),
                ),
              );
            }
            final items = snap.data!.docs;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final user = items[index].data();
                  return ListTile(
                    onTap: () {
                      Get.to(() => ChatsPage(
                            chatUser: user,
                          ));
                    },
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            user.avatar ?? Strings.defaultAvatar,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.occupation ?? ""),
                  );
                });
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}
