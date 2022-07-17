import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_your_month/login/text_with_textbutton.dart';
import '../../config.dart';
import '../controllers/auth_controller.dart';
import '../root.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpButtons extends StatelessWidget {
  const SignUpButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _nameController = nameController,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            '로그인',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(18), color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: Config.screenHeight! * 0.02),
                        ElevatedButton(
                          child: Text('회원가입'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String name = _nameController.text.trim();
                              String email = _emailController.text.trim();
                              String password = _passwordController.text;
                              _authController.signUp(name, email, password);
                            }
                          },
                        ),
                        TextWithTextButton(
                          text: 'Already have an account?',
                          textButtonText: 'Sign in',
                          onPressed: () => Get.offAll(() => root()),
                        ),
                      ],
                    )))));
  }
}
