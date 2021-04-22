import 'dart:io';

import 'package:flash_chat/Models/ModelChat.dart';
import 'package:flash_chat/Models/ModelStatus.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MyWidgets {
  static AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Expanded(flex: 2, child: Text("WhatsApp")),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.wifi),
                GestureDetector(
                  child: Obx(
                    () => Icon(!SessionManager.myController.isDark.value
                        ? Icons.wb_sunny
                        : Icons.wb_sunny_outlined),
                  ),
                  onTap: () {
                    SessionManager.myController
                        .changeTheme(!SessionManager.myController.isDark.value);
                  },
                ),
                Icon(Icons.search),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                      SessionManager.myController.setIsLoggedIn = false;
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget getStatusRow(ModelStatus modelStatus) {
    return Container(
      padding:
      const EdgeInsets.only(left: 5.0, right: 3.0, top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CircleAvatar(
                backgroundImage: modelStatus.myUser.profileImage == ""
                    ? Image.asset("assets/images/place_holder.png").image
                    : Image.network(modelStatus.myUser.profileImage).image),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelStatus.myUser.name,
                      style: Style.kTextStyleBol,
                    ),
                    Text(DateFormat('hh:mm a').format(DateTime.parse(modelStatus.dateTime)), style: Style.kTextStyleNormal),
                  ],
                ),
              )),
          // Container(
          //     child: Column(
          //       children: [
          //         Text(
          //           "01:09",
          //           style: Style.kTextStyleNormal,
          //         ),
          //         Icon(Icons.online_prediction_rounded)
          //       ],
          //     ))
        ],
      ),
    );
  }

  static Widget getUserRow(MyUser user) {
    return Container(
      padding:
          const EdgeInsets.only(left: 5.0, right: 3.0, top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CircleAvatar(
                backgroundImage: user.profileImage == ""
                    ? Image.asset("assets/images/place_holder.png").image
                    : Image.network(user.profileImage).image),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Style.kTextStyleBol,
                    ),
                    Text(user.phoneNumber, style: Style.kTextStyleNormal),
                  ],
                ),
              )),
          // Container(
          //     child: Column(
          //       children: [
          //         Text(
          //           "01:09",
          //           style: Style.kTextStyleNormal,
          //         ),
          //         Icon(Icons.online_prediction_rounded)
          //       ],
          //     ))
        ],
      ),
    );
  }

  static Widget getUseChatRow(
      {String name, String lastMessage, String timeDate, String image}) {
    return Container(
      margin:const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left:3.0,right: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CircleAvatar(
              radius: 22,
                backgroundImage: image == ""
                    ? Image.asset("assets/images/place_holder.png").image
                    : Image.network(image).image),
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.only(left:10.0,top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name, style: Style.kTextStyleBol.copyWith(fontSize: 16)),
                    Text(lastMessage, style: Style.kTextStyleNormal.copyWith(fontSize: 14)),
                    Divider(height: 22,color: Colors.black,)
                  ],
                ),
              )),
          Container(
              child: Column(
            children: [
              Text(
                DateFormat('hh:mm a').format(DateTime.parse(timeDate))   ,
                style: Style.kTextStyleNormal.copyWith(fontSize: 14),
              ),
            ],
          ))
        ],
      ),
    );
  }

  static final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ?  Style.kPrimaryColor : Colors.white,
        ),
      );
    },
  );

  static buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
    DecorationImage backgroundImage,
    double height = 152.0,
  }) {
    return Container(
      color: backgroundColor,
      height: height,
      width: double.infinity,
      child: WaveWidget(
        config: config,
        size: Size(double.infinity, height),
        waveAmplitude: 0,
      ),
    );
  }

  static Widget kWhiteButton({
    String text,
    onPressed(),
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(10),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              child: MyWidgets.spinkit,
              visible: SessionManager.myController.isLoading.value,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                style: Style.kTextStyleBol.copyWith(color:  Style.kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget get showLoading => ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: Tween(begin: 0.1, end: 8.0)
              .animate(SessionManager.myController.listAnimationController),
          builder: (context, child) {
            return ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    Color(0xF2F4EBEE),
                    Color(0xF7F4F4F4),
                    Color(0xFAEBEBF4),
                  ],
                  stops: [
                    0.1,
                    0.3,
                    0.4,
                  ],
                  begin: Alignment(-1.0, -0.3),
                  end: Alignment(1.0, 0.3),
                  tileMode: TileMode.clamp,
                  transform: SlidingGradientTransform(SessionManager
                      .myController.listAnimationController.value),
                ).createShader(bounds);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyWidgets.getUseChatRow(
                    name: "Name",
                    image: "",
                    lastMessage: "Message",
                    timeDate: ".."),
              ),
            );
          },
        );
      });
}
