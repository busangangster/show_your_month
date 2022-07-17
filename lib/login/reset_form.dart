import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_your_month/login/rounded_text_formfield.dart';
import '../../../config.dart';
import '../controllers/auth_controller.dart';

class ResetForm extends StatelessWidget {
  const ResetForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    final _authController = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          RoundedTextFormField(
            hintText: '이메일 ',
            controller: _emailController,
            validator: (value) {
              bool _isEmailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (!_isEmailValid) {
                return '유효하지 않은 이메일 양식입니다.';
              }
              return null;
            },
          ),
          SizedBox(height: Config.screenHeight! * 0.03),
          ElevatedButton(
            child: Text('Reset Password'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _authController.resetPassword(_emailController.text.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
