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
    return Center(
      child: SizedBox(
        width: Config.screenWidth! * 0.9,
        height: Config.screenHeight! * 1.5,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
               SizedBox(height:100.h),
                Column(children: [
                  Container(),
                  Image.asset(
                    'assets/main_logo.png',
                    width: 107.w,
                    height: 107.h,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text("계획들을 수행해가며",
                      style: TextStyle(
                          color: Color(0xff343A40),
                          fontSize: 14.sp,
                          letterSpacing: 1.9.sp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "자신만의 한 달",
                        style: TextStyle(
                            color: Color(0xff458017),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            letterSpacing: 1.9.sp),
                      ),
                      Text("을 키워보세요!",
                          style: TextStyle(
                              color: Color(0xff343A40),
                              fontSize: 14.sp,
                              letterSpacing: 1.9.sp))
                    ],
                  )
                ]),
                SizedBox(height: 50.h),

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
                      height: 80.h,
                    ),
                    Container(
                      width: 287.w,
                      height: 49.h,
                      child:ElevatedButton(

                        child: Text('로그인'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text.trim();
                            String password = _passwordController.text;
                            _authController.signIn(email, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: Color(0xff458017),shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33), // <-- Radius
                        ), ))
                    )

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
                    Text('한 달 키우기 회원이 아니신가요? '),
                    TextButton(
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Color(0xff458017),
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
