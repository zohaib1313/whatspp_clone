import 'package:flash_chat/screens/Widgets/MyWidgets.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Style {
  static const kTextStyleBol =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const kTextStyleNormal =
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static const kInputDecoration = InputDecoration(
      prefixIcon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      labelText: "Phone");


}
