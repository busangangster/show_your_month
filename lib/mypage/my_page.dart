import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_your_month/controllers/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:show_your_month/mypage/setting_page.dart';
import '../theme/colors.dart';

class my_page extends StatefulWidget {
  const my_page({Key? key}) : super(key: key);

  @override
  _my_pageState createState() => _my_pageState();
}

class _my_pageState extends State<my_page> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userProfile!.uid)
        .snapshots();

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
          actions: [
            IconButton(
              onPressed: () {
                Get.to(setting_page(
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
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 56.h,
            ),
            Container(
                //  padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: _userStream,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        final getdata = snapshot.data;
                        if (snapshot.hasData) {
                          print("my_page for test ${getdata?["photoURL"]}");
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(57),
                            child: Image.network(
                              getdata?["photoURL"],
                              height: 140.h,
                              width: 144.w,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.h,
                            ),
                            Row(
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                  stream: _userStream,
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    final getdata = snapshot.data;
                                    if (snapshot.hasData) {
                                      return Text(
                                        '${getdata?["name"]}',
                                        style: TextStyle(
                                          color: Color(0xff171717),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '님',
                                  style: TextStyle(
                                    color: Color(0xff171717),
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: _userStream,
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                final getdata = snapshot.data;
                                if (snapshot.hasData) {
                                  return Text(
                                    '${getdata?["email"]}',
                                    style: TextStyle(
                                      color: Color(0xff495057),
                                      fontSize: 15.sp,
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 11.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 5.0,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 43.h,
                                width: 110.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/green_star.png',
                                        height: 40, width: 30),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text('화분 수')
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ))));
  }
}
