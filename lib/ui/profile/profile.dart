import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';
import 'package:luxury_guide/utils/strings.dart';

import '../../controllers/user_controller.dart';
import 'sub_divider.dart';

class ProfilePage extends StatelessWidget {
  final userCtrl = UserController().to;
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 15),
          avatarName(),
          const SizedBox(height: 15),
          const Divider(
            height: 1,
          ),
          iconTextCard(
            icon: Icons.list,
            title: "Occupation",
            subtitle: "Your details",
            onTap: () async {
              final ctrl = TextEditingController();
              ctrl.text = UserController().to.user.value?.occupation ?? "";
              Get.dialog(Material(
                color: Colors.transparent,
                child: AlertDialog.adaptive(
                  title: const Text('Occupation'),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: ctrl,
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        UserController().to.saveOccupation(ctrl.text);
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ));
            },
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.list_alt,
            title: "Terms and Conditions",
            subtitle: "App usage Terms and Conditions",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            subtitle: "How your data is used",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.group,
            title: "About Us",
            subtitle: "FAQ, Contact 1% Club",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.logout_outlined,
            title: "Log out",
            subtitle: "Log out from current device",
            onTap: () {
              FirebaseController().to.auth.signOut();
              Get.back();
            },
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget iconTextCard(
      {required IconData icon,
      required String title,
      String? subtitle,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
    );
  }

  Widget avatarName() {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  userCtrl.user.value?.avatar ?? Strings.defaultAvatar,
                ),
                fit: BoxFit.cover,
              ),
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => Text(
                    userCtrl.user.value?.name ?? "Not available",
                    style: GoogleFonts.spectral(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    userCtrl.user.value?.email ?? "Email Not available",
                    style: GoogleFonts.spectral(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 15,
          )
        ],
      ),
    );
  }
}
