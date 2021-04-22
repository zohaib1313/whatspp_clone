import 'dart:io';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/screens/Widgets/MyWidgets.dart';
import 'package:flash_chat/utils/AppConstants.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wave/config.dart';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //for storing form state.
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Style.kSecondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.rotate(
              angle: -math.pi / 1,
              child: MyWidgets.buildCard(
                  backgroundColor:Style.kSecondaryColor,
                  config: CustomConfig(
                    colors: [
                      Style.kPrimaryColor[400],
                      Style.kPrimaryColor[300],
                      Style.kPrimaryColor[200],
                      Style.kPrimaryColor[100]
                    ],
                    durations: [18000, 8000, 5000, 12000],
                    heightPercentages: [0.1, 0.2, 0.3, 0.4],
                    blur: null,
                  ),
                  height: MediaQuery.of(context).size.height * 0.1),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Welcome",
                    style: Style.kTextStyleBol
                        .copyWith(color: Colors.black, fontSize: 26),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Sign up for your account",
                    style: Style.kTextStyleNormal.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Center(
              child: Wrap(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:  Style.kPrimaryColor,
                          boxShadow: [
                            BoxShadow(
                              color:  Style.kPrimaryColor,
                              offset: Offset(1.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.05),
                        child: Theme(
                          data: ThemeData(
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor: Colors.white,
                                selectionColor: Colors.white,
                                selectionHandleColor: Colors.white,
                              ),
                              hintColor: Colors.white,
                              primaryColor: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 20),
                                    child: Text(
                                      "Sign up",
                                      style: Style.kTextStyleBol
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextFormField(
                                      controller: _nameController,
                                      decoration: Style.kInputDecoration
                                          .copyWith(labelText: "Name"),
                                      style: Style.kTextStyleNormal.copyWith(
                                          color: Colors.white,
                                          decorationColor: Colors.white),
                                      validator: (text) {
                                        if (text.isEmpty || text == null) {
                                          return "Enter valid name!";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextFormField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: Style.kInputDecoration
                                          .copyWith(
                                              labelText: "Phone  Number",
                                              hintText: "+92306296778"),
                                      style: Style.kTextStyleNormal
                                          .copyWith(color: Colors.white),
                                      validator: (text) {
                                        if (text.isEmpty) {
                                          return "Enter phone number";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0,
                                        bottom: 16.0,
                                        left: 26,
                                        right: 26),
                                    child: Center(
                                      child: Obx(
                                        () => MyWidgets.kWhiteButton(
                                          text: "Sign up",
                                          onPressed: () {
                                            final isValid = _formKey
                                                .currentState
                                                .validate();
                                            if (!isValid) {
                                              return;
                                            }

                                            if (SessionManager.myController
                                                    .selectedImagePath.value ==
                                                '') {
                                              Get.snackbar(
                                                  "Select Profile Image", "",
                                                  backgroundColor:  Style.kPrimaryColor,
                                                  colorText:  Style.kSecondaryColor);
                                              return;
                                            }
                                            SessionManager.myController
                                                .isLoading.value = true;

                                            kIsWeb
                                                ? webPhoneAuth()
                                                : androidPhoneVerification();
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Obx(() {
                                // if(SessionManager.myController.selectedImagePath.value.isNotEmpty)
                                // FirebaseStorage.instance
                                //     .ref()
                                //     .child("Users")
                                //     .child("zohaib")
                                //     .child("ProfileImage")
                                //     .putFile(File(SessionManager
                                //         .myController.selectedImagePath.value))
                                //     .then((snapshot) => {print(snapshot)})
                                //     .catchError((err) => {print(err)});

                                return CircleAvatar(
                                  radius: 33,
                                  backgroundImage: SessionManager.myController
                                              .selectedImagePath.value ==
                                          ''
                                      ? Image.asset(
                                              "assets/images/place_holder.png")
                                          .image
                                      : kIsWeb
                                          ? Image.network((SessionManager
                                                  .myController
                                                  .selectedImagePath
                                                  .value))
                                              .image
                                          : Image.file(
                                              File(SessionManager.myController
                                                  .selectedImagePath.value),
                                            ).image,
                                );
                              }),
                              GestureDetector(
                                onTap: () {
                                  SessionManager.myController.getImage();
                                },
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.add,color:  Style.kPrimaryColor,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }

  void onCodeSent(
      {String verificationId,
      int forceResendingToken,
      ConfirmationResult confirmationResult}) {
    print("code sent  $confirmationResult");
    SessionManager.myController.isLoading.value = false;
    Get.dialog(
      Container(
        color: Colors.transparent,
        child: Center(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  elevation: 12,
                  color: Style.kPrimaryColor.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Theme(
                          data: ThemeData(
                              textSelectionTheme: TextSelectionThemeData(
                                cursorColor: Colors.white,
                                selectionColor: Colors.white,
                                selectionHandleColor: Colors.white,
                              ),
                              hintColor: Colors.white,
                              primaryColor: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextField(
                                  controller: _codeController,
                                  decoration: Style.kInputDecoration.copyWith(
                                    labelText: "Verification code",
                                  ),
                                  style: Style.kTextStyleNormal
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 16,
                                      right: 16),
                                  child: Obx(
                                    () => MyWidgets.kWhiteButton(
                                      text: "Confirm",
                                      onPressed: () async {
                                        if (_codeController.text != null &&
                                            _codeController.text.isNotEmpty) {
                                          SessionManager.myController.isLoading
                                              .value = true;
                                          try {
                                            UserCredential result;
                                            if (kIsWeb) {
                                              print("logging in with web");
                                              result = await confirmationResult
                                                  .confirm(
                                                      _codeController.text);
                                              print(result.user);
                                              loginWithUser(result.user);
                                            } else {
                                              print("logging in with android");

                                              PhoneAuthCredential credential =
                                                  PhoneAuthProvider.credential(
                                                      verificationId:
                                                          verificationId,
                                                      smsCode: _codeController
                                                          .text
                                                          .trim());

                                              result = await _auth
                                                  .signInWithCredential(
                                                      credential);
                                              loginWithUser(result.user);
                                            }
                                          } catch (e) {
                                            print(e.toString());

                                            Get.snackbar("Verification Failed ",
                                                e.toString(),
                                                backgroundColor:  Style.kPrimaryColor,
                                                colorText: Colors.white);
                                            SessionManager.myController
                                                .isLoading.value = false;
                                          }
                                        } else {
                                          Get.snackbar(
                                              "Enter verification code ", "",
                                              backgroundColor:  Style.kPrimaryColor,
                                              colorText: Colors.white);
                                          SessionManager.myController.isLoading
                                              .value = false;
                                        }
                                      },
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  androidPhoneVerification() {
    _auth
        .verifyPhoneNumber(
          phoneNumber: _phoneController.text.trim(),
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: null,
          codeSent: (verficaiotndi, resit) => onCodeSent(
              verificationId: verficaiotndi, forceResendingToken: resit),
          verificationCompleted: null,
          verificationFailed: (failed) {
            Get.snackbar("Verification Failed ", "$failed",
                backgroundColor: Style.kPrimaryColor,
                colorText: Style.kSecondaryColor);
          },
        )
        .then((value) => () {
              _phoneController.clear();
            });
  }

  webPhoneAuth() {
    // Wait for the user to complete the reCAPTCHA & for a SMS code to be sent.
    _auth
        .signInWithPhoneNumber(
            _phoneController.text.trim(),
            RecaptchaVerifier(
              size: RecaptchaVerifierSize.compact,
              theme: RecaptchaVerifierTheme.dark,
              onSuccess: () => print('reCAPTCHA complete!'),
              onError: (FirebaseAuthException error) => print(error),
              onExpired: () => print('reCAPTCHA Expired!'),
            ))
        .then((value) => onCodeSent(confirmationResult: value))
        .catchError((err) => Get.snackbar("Error", err.toString()));
  }

  void loginWithUser(User user) {
    var imagePath = SessionManager.myController.selectedImagePath.value;

    print("logging in");
    print("image path =" + imagePath);

    MyUser myUser = MyUser(
        id: user.uid,
        name: _nameController.text.toString(),
        profileImage: "",
        phoneNumber: _phoneController.text.toString());
    GetStorage().write(AppConstants.KEY_USER, myUser.toJson());
    SessionManager.myController.isLoading.value = false;
    SessionManager.setIsLoggedIn = true;
    FirebaseStorage.instance
        .ref()
        .child("Users")
        .child(myUser.id)
        .child("ProfileImage")
        .child(File(imagePath).uri.pathSegments.last)
        .putFile(File(imagePath))
        .then((snapshot) {
      if (snapshot.state == TaskState.success) {
        print("logging in success");
        snapshot.ref.getDownloadURL().then((downloadUrl) {
          myUser.profileImage = downloadUrl.toString();
          FirebaseFirestore.instance
              .collection("Users")
              .doc(myUser.id)
              .set(myUser.toMap())
              .then((value) {
            Get.back();
            SessionManager.myController.selectedImagePath.value="";
            GetStorage().write(AppConstants.KEY_USER, myUser.toJson());
            SessionManager.myController.isLoading.value = false;
            SessionManager.setIsLoggedIn = true;

          }).catchError((error) => print("Failed to add user: $error"));
        });
      } else {
        print("logging failed");
        print('Error from image repo ${snapshot.state.toString()}');
      }
    });
  }
}
