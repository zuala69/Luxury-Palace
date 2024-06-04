import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';

String? uid() {
  return FirebaseController().to.auth.currentUser?.uid;
}

String combineUids(String uid1, String uid2) {
  if (uid1.compareTo(uid2) < 0) {
    return uid1 + uid2;
  } else {
    return uid2 + uid1;
  }
}

String time(Timestamp timestamp) {
  final dt = timestamp.toDate();
  final parsed = DateFormat("hh:mm a").format(dt);
  return parsed;
}
