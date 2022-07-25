import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:show_your_month/plantpage/plant_setting_page.dart';

class plant_page extends StatefulWidget {
  const plant_page({Key? key}) : super(key: key);

  @override
  _plant_pageState createState() => _plant_pageState();
}

class _plant_pageState extends State<plant_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(plant_setting_page(
                getName: '',
                getEmail: '',
              ));
            },
            icon: const Icon(
              Icons.settings_sharp,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
