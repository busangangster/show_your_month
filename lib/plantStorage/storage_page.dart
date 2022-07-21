import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class storage_Page extends StatefulWidget {
  const storage_Page({Key? key}) : super(key: key);

  @override
  _storage_PageState createState() => _storage_PageState();
}

class _storage_PageState extends State<storage_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/top_bar_logo.png',
          width: 100.w,
          height: 48.h,
        ),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
    );
  }
}
