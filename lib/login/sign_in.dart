import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:show_your_month/login/reset_password.dart';
import 'package:show_your_month/login/rounded_text_formfield.dart';
import 'package:show_your_month/login/sign_up.dart';

import '../../config.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/auth_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    print("sign_in.dart");
    return Center(
      child: SizedBox(
        width: Config.screenWidth! * 0.9,
        height: Config.screenHeight! * 1.5,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Config.screenHeight! * 0.15),
                //Text("Log In",style: TextStyle(fontSize: Config.screenWidth! * 0.08),),
                SizedBox(height: Config.screenHeight! * 0.02),
                Column(children: [
                  Container(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '도움',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          color: Color(0xFFffaa00)),
                    ),
                    Text(
                      '과',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          color: Color(0xFF5B21B6)),
                    ),
                    Text(
                      '소통',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          color: Color(0xFFffaa00)),
                    ),
                    Text(
                      '의 제한 없는 공간',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          color: Color(0xFF5B21B6)),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(),
                    Text(
                      '라이큐',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(22),
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5B21B6)),
                    ),
                    Container(),
                  ]),
                  //SizedBox(height: ScreenUtil().setHeight(9)),
                  Text(
                    '세상의 모든 어려움의',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Color(0xFF979797)),
                  ),
                  Text(
                    '장벽을 허물어주는 어플',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(12),
                        color: Color(0xFF979797)),
                  ),
                ]),
                SizedBox(height: Config.screenHeight! * 0.04),

                Column(
                  children: [
                    buildTextFormFields(),
                    Padding(
                      padding: EdgeInsets.all(0),
                      // EdgeInsets.symmetric(vertical: Config.screenHeight! * 0.005),
                      child: Align(
                        alignment: Alignment(0.8, 0.0),
                        child: TextButton(
                          child: Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () => Get.to(() => const ResetPassword()),
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                      child: Text('로그인'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text;
                          _authController.signIn(email, password);
                        }
                      },
                    ),
                  ],
                ),
                // Platform.isIOS
                //     ? SignInButton(
                //         buttonType: ButtonType.google,
                //         onPressed: () => _authController.signInWithGoogle(),
                //       )
                //     : SignInButton.mini(
                //         buttonType: ButtonType.google,
                //         onPressed: () => _authController.signInWithGoogle(),
                //       ),
                // Platform.isIOS
                //     ? SizedBox(
                //         height: 10.h,
                //       )
                //     : Container(),
                // Platform.isIOS
                //     ? SignInButton(
                //         buttonType: ButtonType.appleDark,
                //         onPressed: () => _authController.signInWithApple(),
                //       )
                //     : Container(),
                // Platform.isIOS
                //     ? SizedBox(
                //         height: 30.h,
                //       )
                //     : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('라이큐 회원이 아니신가요? '),
                    TextButton(
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Color(0xffFFAA00),
                        ),
                      ),
                      onPressed: () => Get.to(() => const SignUp()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    return Column(
      children: [
        RoundedTextFormField(
          controller: _emailController,
          hintText: '이메일',
          // validator: (value) {
          //   bool _isEmailValid = RegExp(
          //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          //       .hasMatch(value!);
          //   if (!_isEmailValid) {
          //     return '유효하지 않은 이메일입니다.';
          //   }
          //   return null;
          // },
        ),
        // Container(
        //   height: ScreenUtil().setHeight(43),
        //   width: ScreenUtil().setWidth(287),
        //   child: TextFormField(
        //     decoration: InputDecoration(
        //       hintText: '아이디',
        //       contentPadding: EdgeInsets.all(15.0),
        //       border: const OutlineInputBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(33.0)),
        //         borderSide: BorderSide.none,
        //       ),
        //       filled: true,
        //       fillColor: Colors.grey[200],
        //     ),
        //   ),
        // ),

        SizedBox(height: Config.screenHeight! * 0.01),
        RoundedTextFormField(
          controller: _passwordController,
          hintText: '비밀번호 ',
          obsecureText: true,
          // validator: (value) {
          //   if (value.toString().length < 6) {
          //     return '6자리 이상';
          //   }
          //   return null;
          // },
        ),
      ],
    );
  }
}
