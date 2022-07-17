import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:show_your_month/login/reset_password.dart';
import 'package:show_your_month/login/rounded_text_formfield.dart';
import 'package:show_your_month/login/sign_up.dart';
import 'package:show_your_month/login/text_with_textbutton.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import '../../../config.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignInForm extends StatefulWidget {
  SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildTextFormFields(),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Config.screenHeight! * 0.005),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Forgot Password?'),
                  onPressed: () => Get.to(() => ResetPassword()),
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Sign in'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text;

                  _authController.signIn(email, password);
                }
              },
            ),
            SizedBox(height: Config.screenHeight! * 0.01),
            TextWithTextButton(
              text: 'Don\'t have an account?',
              textButtonText: 'Sign up',
              onPressed: () => Get.to(() => SignUp()),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    return Column(
      children: [
        RoundedTextFormField(
          controller: _emailController,
          hintText: 'Email',
          validator: (value) {
            bool _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!);
            if (!_isEmailValid) {
              return 'Invalid email.';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.01),
        RoundedTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obsecureText: true,
          validator: (value) {
            if (value.toString().length < 6) {
              return 'Password should be longer or equal to 6 characters.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
