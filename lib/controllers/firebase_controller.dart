import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luxury_guide/models/message.dart';

import '../models/user.dart';
import '../utils/functions.dart';

class FirebaseController extends GetxController {
  FirebaseController get to => Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel?> getUser() async {
    try {
      final data = await store
          .collection("users")
          .withConverter<UserModel>(
            fromFirestore: (data, snap) {
              return UserModel.fromJson(data['data']);
            },
            toFirestore: (data, something) {
              return data.toJson();
            },
          )
          .doc(auth.currentUser?.uid)
          .get();
      return data.data();
    } catch (e) {
      log("Error getting user");
      return null;
    }
  }

  Stream<QuerySnapshot<UserModel>> getUsers() {
    return store
        .collection('users')
        .where("id", isNotEqualTo: uid())
        .withConverter<UserModel>(
      fromFirestore: (data, snap) {
        return UserModel.fromJson(data.data()!);
      },
      toFirestore: (data, something) {
        return data.toJson();
      },
    ).snapshots();
  }

  Stream<QuerySnapshot<Message>> getMessages(String userId) {
    store
        .collection('messages')
        .where(
          "chatterIds",
          isEqualTo: combineUids(
            uid()!,
            userId,
          ),
        )
        .orderBy("sentAt", descending: true)
        .withConverter<Message>(
          fromFirestore: (data, snap) {
            return Message.fromJson(data.data()!);
          },
          toFirestore: (data, something) {
            return data.toJson();
          },
        )
        .get()
        .then((value) {
          log("Getting messages senderId=${uid()} receiverId=$userId :${value.docs.length}");
        });
    final snap = store
        .collection('messages')
        .where(
          "chatterIds",
          isEqualTo: combineUids(
            uid()!,
            userId,
          ),
        )
        .withConverter<Message>(
      fromFirestore: (data, snap) {
        return Message.fromJson(data.data()!);
      },
      toFirestore: (data, something) {
        return data.toJson();
      },
    ).snapshots();
    return snap;
  }

  // Stream<DocumentSnapshot<Chat>> getChat(String userId) {
  //   return store
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection("chats")
  //       .doc(userId)
  //       .withConverter<Chat>(
  //     fromFirestore: (data, snap) {
  //       return Chat.fromJson(data.data()!);
  //     },
  //     toFirestore: (data, something) {
  //       return data.toJson();
  //     },
  //   ).snapshots();
  // }

  void saveMessage(Message message) {
    store.collection('messages').add(message.toJson());
  }

  void signIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final usr = userCredential.user;
        if (usr == null) {
          return;
        }
        final userModel = UserModel(
          id: usr.uid,
          name: usr.displayName ?? "",
          email: usr.email ?? "test@email.com",
        );
        //read once to check if existing/sign in
        store.collection("users").doc(usr.uid).get().then((value) {
          if (value.exists) {
            //dont save data if exist
            return;
          }
          //save only when user is new
          store.collection("users").doc(usr.uid).set(userModel.toJson());
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // Handle the error here
        } else if (e.code == 'invalid-credential') {
          // Handle the error here
        }
      }
    }
  }
}
