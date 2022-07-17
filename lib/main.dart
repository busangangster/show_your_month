import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:show_your_month/root.dart';
import 'controllerBindings.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(376, 812),
        builder: (context, child) {
          return GetMaterialApp(
              initialBinding: ControllerBindings(),
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(builder: (context, AsyncSnapshot snapshot) {
                return root();
                // return BottomNavigation();
              }));
        });
  }
}
