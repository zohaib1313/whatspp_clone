import 'package:flash_chat/utils/AppConstants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Models/Users.dart';

class MyController extends GetxController {
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

  var selectedImagePath = ''.obs;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      print(selectedImagePath);
    } else {
      print('No image selected.');
    }
  }

  RxBool isLoading = false.obs;




}
