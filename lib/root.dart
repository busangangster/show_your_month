import 'package:show_your_month/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login/sign_in.dart';
import 'login/sign_up.dart';
import 'login/welcome_page.dart';
import 'navigation_page.dart';

class root extends StatefulWidget {
  const root({Key? key}) : super(key: key);

  @override
  State<root> createState() => _rootState();
}

class _rootState extends State<root> {
  User? user;
  late bool isSign;

  FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((event) => updateUserState(event));
    isSign = false;
  }

  updateUserState(event) {
    user = event;
    if (user == null) {
      isSign = false;
    } else {
      isSign = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return GetBuilder<AuthController>(
      builder: (_) {
        print("root.dart");
        return isSign
            ? _.isFirstSignIn.value
                ? _.isEmailSignIn.value // 구글 로그인 등
                    ? WelcomePage() // sign in하고, 첫 sign in 이고, email sign in인 경우
                    : const SignUp() // sign in이고, 첫 sign in이고, email sign in이 아닌경우
                : navigation_page() // sign in 되어 있는데, 첫 로그인이 아닌경우
            : Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.screenWidth! * 0.0),
                    child: const SignIn(), // sign in 되어 있지 않은 경우
                  ),
                ),
              );
      },
    );
  }
}
