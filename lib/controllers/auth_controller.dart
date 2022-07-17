import '../root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../theme/colors.dart';

class AuthController extends GetxController {
  var displayName = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  // var isSignedIn = false.obs;
  var isFirstSignIn = false.obs;
  var isEmailSignIn = true.obs;

  User? get userProfile => auth.currentUser;
  User? currentUser;

  // token 추가
  // String? _token;
  //late FirebaseMessaging messaging;

  // @override
  // void onInit() {
  //   // print("AUTH: ${isSignedIn}");
  //   // displayName = userProfile != null ? userProfile!.displayName! : '';
  //   messaging = FirebaseMessaging.instance;
  //   messaging.getToken().then((value) {
  //     _token = value;
  //     print("token: $_token");
  //   });
  //   super.onInit();
  // }

  void signUp(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = name;
        auth.currentUser!.updateDisplayName(name);
      });

      //firestore에 저장
      var firebaseUser = FirebaseAuth.instance.currentUser;
      //.then((currentUser)  => FirebaseFirestore.instance
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser!.uid)
          .set({
        "name": name,
        "email": firebaseUser.email,
        "uid": firebaseUser.uid,
        "photoURL":
            "https://firebasestorage.googleapis.com/v0/b/wegolego-bf94b.appspot.com/o/liveQ_logo.jpg?alt=media&token=8b719a18-60db-4124-ae5e-01a5375d6a1c",
        //    "token": _token,
        "timeRegister": DateTime.now().millisecondsSinceEpoch.toString(),
        "ask": 0,
        "help": 0,
        "getHeart": 0,
        "feedback": false,
        //email 로그인에 한하여 이 데이터가 필요하다.
        "firstTime": true,
        "notificationOn": true,
        "frienduid": [],
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .collection('thankLetter')
          .add({
        'thankLetter': "가입해 주셔서 감사합니다.",
        'name': "위고레고",
        "timeRegister": DateTime.now().millisecondsSinceEpoch.toString(),
      });
      isFirstSignIn.value = true;
      update();
      // print("token: $_token");

      //   await FirebaseFirestore.instance.collection('count').doc('counter').update({"count": FieldValue.increment(1)});
      Get.offAll(() => root());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void signIn(String email, String password) async {
    //Google과 apple은 로그인과정이 동일하게 진행이 되는데 email로 로그인하게 되면 이 과정이 불가능함
    //그래서 여기서 처음인지 분별하는 과정이 필요하다.
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          displayName = userProfile!.displayName!;
          //true인지 false인지 확인해서 가져오고 업데이트 시켜줌.
          FirebaseFirestore.instance
              .collection("users")
              .doc(userProfile!.uid)
              .get()
              .then((DocumentSnapshot ds) {
            if (ds['firstTime'] == true) {
              isFirstSignIn.value = true;
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userProfile!.uid)
                  .update({
                'firstTime': false,
                // 'firstTime': true,
              });
            }
          });
        },
      );
      // isSignedIn.value = true;
      isEmailSignIn.value = true;
      update();
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userProfile!.uid)
      //     .update({
      //   'token': _token,
      //   // 'firstTime': true,
      // });
      // print("token: $_token");
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
        'Error occurred!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void signout() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userProfile!.uid)
          .get()
          .then((DocumentSnapshot documentsnapshot) {
        if (documentsnapshot.exists != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userProfile!.uid)
              .update({
            'token': "signOut",
          });
        }
      });

      await auth.signOut();
      await _googleSignIn.signOut();

      // await FirebaseFirestore.instance.collection('users').doc(userProfile!.uid).update(
      //        {'token' : FieldValue.delete()});
      displayName = '';
      // isSignedIn.value = false;
      update();
      Get.offAll(() => root());
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void inactiveUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userProfile!.uid)
          .update({'first time': false});
      signout();
      displayName = '';
      // isSignedIn.value = false;
      update();
      Get.offAll(() => root());
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void deleteUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .collection('thankLetter')
          .doc(currentUser!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .delete();
      await FirebaseAuth.instance.currentUser!.delete();
      displayName = '';
      // isSignedIn.value = false;
      update();
      Get.offAll(() => root());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must re-authenticate before this operation can be executed.');
      }
    }
  }
}

// to capitalize first letter of a Sting
extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
