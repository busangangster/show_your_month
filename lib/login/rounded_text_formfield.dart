import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config.dart';

class RoundedTextFormField extends StatelessWidget {
  const RoundedTextFormField({
    Key? key,
    this.controller,
    this.obsecureText = false,
    @required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? obsecureText;
  final String? hintText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(43),
      width: ScreenUtil().setWidth(287),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText!,
        decoration: InputDecoration(
          hintText: hintText!,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.all(15.0),
          focusedBorder: OutlineInputBorder(
            //borderSide: BorderSide(color: Colors.green),
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
