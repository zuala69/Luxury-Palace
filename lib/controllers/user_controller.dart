import 'dart:developer';

import 'package:get/get.dart';
import 'package:luxury_guide/controllers/firebase_controller.dart';
import 'package:luxury_guide/utils/functions.dart';

import '../models/user.dart';

class UserController extends GetxController {
  UserController get to => Get.find();

  Rxn<UserModel> user = Rxn();

  @override
  void onReady() {
    getUser();
    super.onReady();
  }

  void getUser() {
    FirebaseController()
        .to
        .store
        .collection("users")
        .doc(
          uid(),
        )
        .withConverter<UserModel>(
          fromFirestore: (data, something) {
            return UserModel.fromJson(data.data()!);
          },
          toFirestore: (data, something) {
            return data.toJson();
          },
        )
        .snapshots()
        .listen((event) {
          user.value = event.data();
          log("Users data is: ${user.value?.toJson()}");
        });
  }
}
