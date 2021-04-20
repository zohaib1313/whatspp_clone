import 'dart:async';
import 'package:flash_chat/screens/ChatScreenMain.dart';
import 'package:flash_chat/utils/AppConstants.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Models/Users.dart';

class MyController extends GetxController with SingleGetTickerProviderMixin {
  RxBool isDark = (GetStorage().read(AppConstants.IS_DARK_THEME) ?? false)
      ? true.obs
      : false.obs;

  RxBool rXisLoggedIn =
      (GetStorage().read(AppConstants.KEY_IS_LOGGED_IN) ?? false)
          ? true.obs
          : false.obs;

  set setIsLoggedIn(bool value) {
    GetStorage().write(AppConstants.KEY_IS_LOGGED_IN, value);
    rXisLoggedIn.value = value;
  }

  void changeTheme(bool value) {
    GetStorage().write(AppConstants.IS_DARK_THEME, value);
    isDark.value = value;
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      print(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  var selectedImagePath = ''.obs;

  RxBool isLoading = false.obs;






  AnimationController listAnimationController;
  @override
  void onInit() {
    this.listAnimationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1500));
    super.onInit();
  }

  @override
  void dispose() {
    listAnimationController.dispose();
    print("disposed");
    super.dispose();
  }
}
