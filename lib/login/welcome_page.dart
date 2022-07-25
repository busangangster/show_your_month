import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:show_your_month/home/home_page.dart';
import 'package:show_your_month/navigation_page.dart';

import '../controllers/auth_controller.dart';

class welcomeController extends GetxController {
  late bool startBut = false;

  changetrue() {
    startBut = true;
    update();
  }

  changefalse() {
    startBut = false;
    update();
  }
}

// ignore: camel_case_types
class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;

  @override
  Widget build(BuildContext context) {
    Get.put(welcomeController());
    bool getindex = false;
    final List<Widget> steps = [
      _step1(),
      _step2(),
      _step3(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints.expand(height: 480),
                  child: ElevatedButton(
                    child: Text(
                      '홈으로 고고씽 ~~ ',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () => Get.to(() => navigation_page()),
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                  ),
                  // child: Swiper(
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return steps[index];
                  //   },
                  //   onIndexChanged: (value) {
                  //     if (value == 2) {
                  //       Get.find<welcomeController>().changetrue();
                  //     } else {
                  //       Get.find<welcomeController>().changefalse();
                  //     }
                  //   },
                  //   loop: false,
                  //   autoplay: true,
                  //   itemCount: steps.length,
                  //   viewportFraction: 0.8,
                  //   scale: 0.9,
                  //   pagination: SwiperPagination(
                  //     alignment: Alignment.bottomCenter,
                  //     builder: DotSwiperPaginationBuilder(
                  //       color: Colors.grey[200],
                  //       activeColor: Color(0XFF874BD9),
                  //     ),
                  //   ),
                  // ),
                ),
                GetBuilder<welcomeController>(
                    init: welcomeController(),
                    builder: (_) {
                      return _.startBut
                          ? SizedBox(
                              height: ScreenUtil().setHeight(55),
                              width: ScreenUtil().setHeight(400),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final _authController =
                                      Get.find<AuthController>();
                                  _authController.isFirstSignIn.value = false;
                                  _authController.update();

                                  Get.offAll(navigation_page());
                                },
                                child: Text(
                                  '시작하기',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffFFAA00),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: ScreenUtil().setHeight(55),
                            );
                    }),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _step1() {
  return Column(children: [
    Text(
      '라이큐와 함께 해주셔서',
      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
    ),
    Text(
      '감사합니다! ',
      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
    ),
    SizedBox(
      height: 30,
    ),
    SizedBox(height: ScreenUtil().setHeight(20)),
    Text(
      '세상의 모든 인재가 당신을 도와줄거에요',
      style: TextStyle(fontSize: ScreenUtil().setSp(16)),
    ),
    SizedBox(
      height: ScreenUtil().setHeight(9),
    ),
    Text(
      '라이큐 : 실시간 영상을 통해',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
    Text(
      '누구나 도움을 주고 받을 수 있는 서비스',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
  ]);
}

Widget _step2() {
  return Column(children: [
    Column(children: [
      Text(
        '라이큐와 함께 해주셔서',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      Text(
        '감사합니다! ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      SizedBox(
        height: 30,
      ),
      SizedBox(height: ScreenUtil().setHeight(20)),
      Text(
        '답변자가 되어 도움을 주세요',
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(9),
      ),
      Text(
        '자신있는 분야에 대해',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
      Text(
        '답변해서 세상을 밝혀주세요',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    ]),
  ]);
}

Widget _step3() {
  return Column(children: [
    Column(children: [
      Text(
        '라이큐에 오신 모두 ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      Text(
        '환영합니다! ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      SizedBox(
        height: 30,
      ),
      SizedBox(height: ScreenUtil().setHeight(20)),
      Text(
        '질문자가 되어 도움을 받아보세요',
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(9),
      ),
      Text(
        '궁금한 분야를 답변자에게 실시간으로',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
      Text(
        '직접 묻고 답변을 받을 수 있어요',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    ]),
  ]);
}
