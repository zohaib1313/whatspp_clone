
import 'package:get/get.dart';
import '../controller.dart';

class SessionManager {
  //static MyUser _myUser;

  static final myController = Get.find<MyController>();

  static bool get setIsLoggedIn => myController.rXisLoggedIn.value;

  static set setIsLoggedIn(bool value) {
    myController.setIsLoggedIn = value;
  }

  // static getUser() {
  //   if (_myUser == null) {
  //     _myUser =
  //         MyUser.fromJson(((storage.read(AppConstants.KEY_USER)))) ?? null;
  //   } else {
  //     return _myUser;
  //   }
  // }
}
