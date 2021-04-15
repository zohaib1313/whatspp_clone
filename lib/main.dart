import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/controller.dart';
import 'package:flash_chat/screens/ChatUserScreen.dart';
import 'package:flash_chat/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/HomePage.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(MyController());
  await Firebase.initializeApp();
   runApp(HomeScreen());
  // runApp(ChatUserScreen(MyUser(
  //     name: "Zohaib", phoneNumber: "03062196778", profileImage: "", id: "12")));
}
