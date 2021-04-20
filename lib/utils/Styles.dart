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

  // static const kShimmerGradient = LinearGradient(
  //   colors: [
  //     Color(0xFFEBEBF4),
  //     Color(0xFFF4F4F4),
  //     Color(0xFFEBEBF4),
  //   ],
  //   stops: [
  //     0.1,
  //     0.3,
  //     0.4,
  //   ],
  //   begin: Alignment(-1.0, -0.3),
  //   end: Alignment(1.0, 0.3),
  //   tileMode: TileMode.clamp,
  //    transform: SlidingGradientTransform(22.3),
  // );



}

class SlidingGradientTransform extends GradientTransform {
 const SlidingGradientTransform(this.slidePercent);
  final double slidePercent;

  @override
  Matrix4 transform(Rect bounds, {TextDirection textDirection}) {
    print(slidePercent);
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
