import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_your_month/controllers/auth_controller.dart';

class my_page extends StatefulWidget {
  const my_page({Key? key}) : super(key: key);

  @override
  _my_pageState createState() => _my_pageState();
}

class _my_pageState extends State<my_page> {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text('my_page'),
          ),
          ListTile(
            title: Text(
              "로그아웃",
              style: TextStyle(fontSize: 14, color: Color(0xFF495057)),
            ),
            trailing: Container(
              height: 24,
              width: 24,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFADB5BD),
              ),
            ),
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text("로그아웃 하시겠습니까?"),
                  content:
                  const Text("로그아웃시 회원님의 정보는 유지되고 다시 로그인이 필요합니다."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _authController.signout();
                        },
                        child: const Text("YES")),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("NO"))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
