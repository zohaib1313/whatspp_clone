
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/utils/AppConstants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controller.dart';

class SessionManager {
  //static MyUser _myUser;

  static final myController = Get.find<MyController>();

  static bool get setIsLoggedIn => myController.rXisLoggedIn.value;

  static set setIsLoggedIn(bool value) {
    myController.setIsLoggedIn = value;
  }

  static MyUser getCurrentUser()=>MyUser.fromJson(GetStorage().read(AppConstants.KEY_USER));


  // static getUser() {
  //   if (_myUser == null) {
  //     _myUser =
  //         MyUser.fromJson(((storage.read(AppConstants.KEY_USER)))) ?? null;
  //   } else {
  //     return _myUser;
  //   }
  // }
}
