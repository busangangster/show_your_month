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
      height: ScreenUtil().setHeight(45),
      width: ScreenUtil().setWidth(278),
      child: TextFormField(
        style: TextStyle(fontSize: 14),
        controller: controller,
        obscureText: obsecureText!,
        decoration: InputDecoration(
          hintText: hintText!,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15.0),
          focusedBorder: OutlineInputBorder(
            //borderSide: BorderSide(color: Colors.green),
            borderSide: const BorderSide(width: 1, color: Color(0xffD0D0D0)),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xffD0D0D0)),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
