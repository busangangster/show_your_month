import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:show_your_month/controllers/auth_controller.dart';
import 'package:show_your_month/login/rounded_text_formfield.dart';
import 'package:show_your_month/login/welcome_page.dart';

import 'package:flutter/material.dart';
import '../../config.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../root.dart';
import '../theme/colors.dart';
import '../theme/text_style.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _checkBoxValue = false;
  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;
  bool _checkBoxValue3 = false;

  bool isEnabled = false;
  bool isButtonActive = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return (GetBuilder<AuthController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          // title: const Text('Sign Up',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(color: Colors.black),
          // ),
          elevation: 0.0,
          backgroundColor: Colors.white,

          leading: _.isEmailSignIn.value
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                  color: Colors.black,
                )
              : Container(),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Config.screenWidth! * 0.04),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Config.screenHeight! * 0.07),
                    Text(
                      "회원가입 ",
                      style: TextStyle(fontSize: Config.screenWidth! * 0.06),
                    ),
                    SizedBox(height: Config.screenHeight! * 0.05),
                    //이메일 로그인, ios 로그인에 따라 변경
                    _.isEmailSignIn.value
                        ? buildEmailTextFormFields()
                        : buildNotEmailTextFormFields(),
                    SizedBox(height: Config.screenHeight! * 0.05),

                    SizedBox(
                      height: ScreenUtil().setHeight(49),
                      width: ScreenUtil().setWidth(287),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return AlertDialog(
                                        // context: context,
                                        actions: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '이용약관 ',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(18),
                                                    ),
                                                  )
                                                  // IconButton(onPressed: (){},
                                                  //     icon: Icon(Icons.done))
                                                ],
                                              ),
                                              SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(50)),
                                              Row(children: [
                                                Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  checkColor: Colors.white,
                                                  activeColor:
                                                      Color(0xffFFAA00),
                                                  value: _checkBoxValue,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _checkBoxValue = value!;

                                                      if (_checkBoxValue ==
                                                          true) {
                                                        _checkBoxValue1 = true;
                                                        _checkBoxValue2 = true;
                                                        _checkBoxValue3 = true;

                                                        isEnabled = true;
                                                      }
                                                      ;
                                                      if (_checkBoxValue ==
                                                          false) {
                                                        _checkBoxValue1 = false;
                                                        _checkBoxValue2 = false;
                                                        _checkBoxValue3 = false;
                                                        isEnabled = false;
                                                      }
                                                      ;
                                                    });
                                                  },
                                                ),
                                                Text('약관 전체동의 '),
                                              ]),
                                              SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(4)),
                                              Container(
                                                height: 1,
                                                width: double.maxFinite,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(4)),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(width: ScreenUtil().setWidth(15),),
                                                    Row(children: [
                                                      Checkbox(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        checkColor:
                                                            Colors.white,
                                                        activeColor:
                                                            Color(0xffFFAA00),
                                                        value: _checkBoxValue1,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            _checkBoxValue1 =
                                                                value!;

                                                            if (_checkBoxValue1 ==
                                                                false) {
                                                              _checkBoxValue =
                                                                  false;
                                                              isEnabled = false;
                                                            }
                                                            ;

                                                            if (_checkBoxValue1 == true &&
                                                                _checkBoxValue2 ==
                                                                    true &&
                                                                _checkBoxValue3 ==
                                                                    true) {
                                                              _checkBoxValue =
                                                                  true;
                                                              isEnabled = true;
                                                            }
                                                            ;
                                                          });
                                                        },
                                                      ),
                                                      Text('서비스 이용약관 동의 (필수)'),
                                                    ]),
                                                    IconButton(
                                                        onPressed: () {
                                                          termsOfUseDialog();
                                                        },
                                                        icon: Icon(Icons
                                                            .arrow_forward_ios_rounded))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(children: [
                                                      Checkbox(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        checkColor:
                                                            Colors.white,
                                                        activeColor:
                                                            Color(0xffFFAA00),
                                                        value: _checkBoxValue2,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            _checkBoxValue2 =
                                                                value!;

                                                            if (_checkBoxValue2 ==
                                                                false) {
                                                              _checkBoxValue =
                                                                  false;
                                                              isEnabled = false;
                                                            }
                                                            ;
                                                            if (_checkBoxValue1 == true &&
                                                                _checkBoxValue2 ==
                                                                    true &&
                                                                _checkBoxValue3 ==
                                                                    true) {
                                                              _checkBoxValue =
                                                                  true;
                                                              isEnabled = true;
                                                            }
                                                            ;
                                                          });
                                                        },
                                                      ),
                                                      Text('개인정보 처리방침 (필수)'),
                                                    ]),
                                                    IconButton(
                                                        onPressed: () {
                                                          privacyPolicyDialog();
                                                        },
                                                        icon: Icon(Icons
                                                            .arrow_forward_ios_rounded))
                                                  ]),
                                              Container(
                                                  height: ScreenUtil()
                                                      .setHeight(55),
                                                  width: ScreenUtil()
                                                      .setHeight(400),
                                                  child: ElevatedButton(
                                                      onPressed: isEnabled
                                                          ? () {
                                                              if (_.isEmailSignIn
                                                                      .value ==
                                                                  true) {
                                                                String name =
                                                                    _nameController
                                                                        .text
                                                                        .trim();
                                                                String email =
                                                                    _emailController
                                                                        .text
                                                                        .trim();
                                                                String
                                                                    password =
                                                                    _passwordController
                                                                        .text;
                                                                _authController
                                                                    .signUp(
                                                                        name,
                                                                        email,
                                                                        password);
                                                              } else {
                                                                FirebaseAuth
                                                                    auth =
                                                                    FirebaseAuth
                                                                        .instance;

                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(auth
                                                                        .currentUser!
                                                                        .uid)
                                                                    .update({
                                                                  'name':
                                                                      _nameController
                                                                          .text
                                                                });

                                                                _.displayName =
                                                                    _nameController
                                                                        .text;
                                                                auth.currentUser!
                                                                    .updateDisplayName(
                                                                        _nameController
                                                                            .text);

                                                                Get.offAll(
                                                                    WelcomePage());
                                                              }
                                                            }
                                                          : null,
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: const Color(
                                                            0xffFFAA00),
                                                      ),
                                                      child: Text('회원가입 완료')))
                                            ],
                                          )
                                        ]);
                                  });
                                });
                          }
                        },
                        child: Text(
                          _.isEmailSignIn.value ? "회원가입" : "회원가입 후 로그인",
                          style: TextStyle(
                              //color: Colors.white,
                              fontSize: Config.screenWidth! * 0.04),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    _.isEmailSignIn.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('이미 계정이 있으신가요? '),
                              TextButton(
                                child: Text(
                                  '로그인 ',
                                  style: TextStyle(
                                      color: AppColors.primaryColor[800]),
                                ),
                                onPressed: () => Get.offAll(() => root()),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }

  void termsOfUseDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절

            //Dialog Main Title
            backgroundColor: AppColors.grey[700],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "이용약관",
                      style: AppTextStyle.koBody1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 50.w),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ],
            ),

            //
            content: SingleChildScrollView(
              child: Container(
                //height: 600.h,
                width: 376.w,
                // padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
                //  decoration: BoxDecoration(
                //    color: AppColors.grey[200],
                //    borderRadius: BorderRadius.circular(22),
                //  ),
                child: Text(
                  '''서비스 이용약관

제 1장 총칙
제 1조 (목적)
이 약관은 “위고레고”(이하 “회사”라 합니다)가 제공하는 “라이큐”(이하 ‘서비스’라 합니다)를 회사와 이용계약을 체결한 ‘고객’이 이용함에 있어 필요한 회사와 고객의 권리 및 의무, 기타 제반 사항을 정함을 목적으로 합니다. 

제 2조 (약관 외 준칙)
이 약관에 명시되지 않은 사항에 대해서는 위치 정보의 보호 및 이용 등에 관한 법률, 전기통신사업법, 정보통신망 이용 촉진및 보호 등에 관한 법률 등 관계법령 및 회사가 정한 서비스의 세부이용지침 등의 규정에 따릅니다. 

제 2장 서비스의 이용
제 3조 (가입자격)
① 서비스에 가입할 수 있는 자는 Application 이 설치가능한 모든 사람 입니다.

제 4조 (서비스 가입)
① “Application 관리자”가 정한 본 약관에 고객이 동의하면 서비스 가입의 효력이 발생합니다.
②“Application 관리자”는 다음 각 호의 고객 가입신청에 대해서는 이를 승낙하지 아니할 수 있습니다. 
     1. 고객 등록 사항을 누락하거나 오기하여 신청하는 경우
     2. 공공질서 또는 미풍양속을 저해하거나 저해할 목적으로 신청한 경우
     3. 기타 회사가 정한 이용신청 요건이 충족되지 않았을 경우 

제 5조 (서비스의 탈퇴)
서비스 탈퇴를 희망하는 고객은 “Application 담당자”가 정한 소정의 절차(설정메뉴의 탈퇴)를 통해 서비스 해지를 신청할 수 있습니다.
 
 제 6조 (서비스의 수준)
① 서비스의 이용은 연중무휴 1일 24시간을 원칙으로 합니다. 단, 회사의 업무상이나 기술상의 이유로 서비스가 일시 중지될 수 있으며, 운영상의 목적으로 회사가 정한 기간에는 서비스가 일시 중지될 수 있습니다. 이러한 경우 회사는 사전 또는 사후에 이를 공지합니다. 
② 위치정보는 관련 기술의 발전에 따라 오차가 발생할 수 있습니다. 

제 7조 (서비스 이용의 제한 및 정지)
회사는 고객이 다음 각 호에 해당하는 경우 사전 통지 없이 고객의 서비스 이용을 제한 또는 정지하거나 직권 해지를 할 수 있습니다. 
     1. 타인의 서비스 이용을 방해하거나 타인의 개인정보를 도용한 경우
     2. 서비스를 이용하여 법령, 공공질서, 미풍양속 등에 반하는 행위를 한 경우

제 8조 (서비스의 변경 및 중지)
① 회사는 다음 각 호의 1에 해당하는 경우 고객에게 서비스의 전부 또는 일부를 제한, 변경하거나 중지할 수 있습니다. 
     1. 서비스용 설비의 보수 등 공사로 인한 부득이한 경우
     2. 정전, 제반 설비의 장애 또는 이용량의 폭주 등으로 정상적인 서비스 이용에 지장이 있는 경우
     3. 서비스 제휴업체와의 계약 종료 등과 같은 회사의 제반 사정 또는 법률상의 장애 등으로 서비스를 유지할 수 없는 경우
     4.기타 천재지변, 국가비상사태 등 불가항력적 사유가 있는 경우 
② 제1항에 의한 서비스 중단의 경우에는 회사는 인터넷 등에 공지하거나 고객에게 통지합니다. 다만, 회사가 통제할 수 없는 사유로 인한 서비스의 중단 (운영자의 고의, 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 사후에 통지합니다. 

제 5장 기타
제 19조 (회사의 연락처)
회사의 상호 다음과 같습니다.
1. 상호: “위고레고”

제 20조 (양도금지)
고객 및 회사는 고객의 서비스 가입에 따른 본 약관상의 지위 또는 권리,의무의 전부 또는 일부를 제3자에게 양도, 위임하거나 담보제공 등의 목적으로 처분할 수 없습니다. 

제 21조 (손해배상)
① 고객의 고의나 과실에 의해 이 약관의 규정을 위반함으로 인하여 회사에 손해가 발생하게 되는 경우, 이 약관을 위반한 고객은 회사에 발생하는 모든 손해를 배상하여야 합니다.
② 고객이 서비스를 이용함에 있어 행한 불법행위나 고객의 고의나 과실에 의해 이 약관 위반행위로 인하여 회사가 당해 고객 이외의 제3자로부터 손해배상청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 당해 고객은 그로 인하여 회사에 발생한 손해를 배상하여야 합니다. 
③ 회사가 위치정보의 보호 및 이용 등에 관한 법률 제 15조 내지 제26조의 규정을 위반한 행위 혹은 회사가 제공하는 서비스로 인하여 고객에게 손해가 발생한 경우, 회사가 고의 또는 과실 없음을 입증하지 아니하면, 고객의 손해에 대하여 책임을 부담합니다.

제 22조 (면책사항)
① 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.
② 회사는 고객의 귀책사유로 인한 서비스의 이용장애에 대하여 책임을 지지 않습니다.
③ 회사는 고객이 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며, 그 밖에 서비스를 통하여 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다.
④ 회사에서 제공하는 서비스 및 서비스를 이용하여 얻은 정보에 대한 최종판단은 고객이 직접 하여야 하고, 그에 따른 책임은 전적으로 고객 자신에게 있으며, 회사는 그로 인하여 발생하는 손해에 대해서 책임을 부담하지 않습니다. 
⑤ 회사의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우 회사는 인터넷 홈페이지 등에 이를 공지하거나 E-mail 등의 방법으로 고객에게 통지합니다. 단, 회사가 통제할 수 없는 사유로 인하여 사전 공지가 불가능한 경우에는 사후에 공지합니다. 

제 23조 (분쟁의 해결 및 관할법원)
① 서비스 이용과 관련하여 회사와 고객 사이에 분쟁이 발생한 경우, 회사와 고객은 분쟁의 해결을 위해 성실히 협의합니다.
② 제1항의 협의에서도 분쟁이 해결되지 않을 경우 양 당사자는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제33조의 규정에 의한 개인정보분쟁조정위원회에 분쟁조정을 신청할 수 있습니다. '''
                  // validator: validator,
                  ,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });
  }

  void privacyPolicyDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            backgroundColor: AppColors.grey[700],
            //Dialog Main Title
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "개인정보 처리방침",
                      style: AppTextStyle.koBody1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ],
            ),

            //
            content: SingleChildScrollView(
              child: Container(
                //height: 600.h,
                width: 376.w,
                // padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
                //  decoration: BoxDecoration(
                //    color: AppColors.grey[200],
                //    borderRadius: BorderRadius.circular(22),
                //  ),
                child: Text(
                  '''< WegoLego >('https://wegolego.tistory.com/1'이하 '안드로이드 App')은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.

○ 이 개인정보처리방침은 2021년 11월 10부터 적용됩니다.

 

제1조(개인정보의 처리 목적)

< WegoLego >('https://wegolego.tistory.com/1'이하 '안드로이드 App')은(는) 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.




제2조(개인정보의 처리 및 보유 기간)

① < WegoLego >은(는) 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.

1.<홈페이지 회원가입 및 관리>
<홈페이지 회원가입 및 관리>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<5년>까지 위 이용목적을 위하여 보유.이용됩니다.
보유근거 : 홈페이지 회원가입 및 관리
관련법령 :
예외사유 :



제3조(개인정보의 제3자 제공)

① < WegoLego >은(는) 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 「개인정보 보호법」 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.

② < WegoLego >은(는) 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.

1. < >
개인정보를 제공받는 자 :
제공받는 자의 개인정보 이용목적 :
제공받는 자의 보유.이용기간:



제4조(개인정보처리 위탁)

① < WegoLego >은(는) 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.

1. < >
위탁받는 자 (수탁자) :
위탁하는 업무의 내용 :
위탁기간 :
② < WegoLego >은(는) 위탁계약 체결시 「개인정보 보호법」 제26조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.

③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.




제5조(정보주체와 법정대리인의 권리·의무 및 그 행사방법)



① 정보주체는 WegoLego에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.

② 제1항에 따른 권리 행사는WegoLego에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 WegoLego은(는) 이에 대해 지체 없이 조치하겠습니다.

③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.

④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.

⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.

⑥ WegoLego은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.




제6조(처리하는 개인정보의 항목 작성)

① < WegoLego >은(는) 다음의 개인정보 항목을 처리하고 있습니다.

1< 홈페이지 회원가입 및 관리 >
필수항목 : 이메일, 비밀번호
선택항목 :



제7조(개인정보의 파기)


① < WegoLego > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.

② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.
1. 법령 근거 :
2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜

③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
1. 파기절차
< WegoLego > 은(는) 파기 사유가 발생한 개인정보를 선정하고, < WegoLego > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.

2. 파기방법

전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다




제8조(개인정보의 안전성 확보 조치)

< WegoLego >은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.

1. 정기적인 자체 감사 실시
개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.

2. 개인정보 취급 직원의 최소화 및 교육
개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.

3. 내부관리계획의 수립 및 시행
개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.

4. 개인정보의 암호화
이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.

5. 개인정보에 대한 접근 제한
개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.





제9조(개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항)



WegoLego 은(는) 정보주체의 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용하지 않습니다.

제10조 (개인정보 보호책임자)

① WegoLego 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

▶ 개인정보 보호책임자
성명 :이산하
직책 :CTO
직급 :팀원
연락처 :01029851932, wegolego21@gmail.com,
※ 개인정보 보호 담당부서로 연결됩니다.

▶ 개인정보 보호 담당부서
부서명 :WegoLego
담당자 :이산하
연락처 :01029851932, wegolego21@gmail.com,
② 정보주체께서는 WegoLego 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. WegoLego 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.

제11조(개인정보 열람청구)
정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다.
< WegoLego >은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.

▶ 개인정보 열람청구 접수·처리 부서
부서명 :
담당자 :
연락처 : , ,



제12조(권익침해 구제방법)



정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.

1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)
2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)
3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)
4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)

「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.

※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.


제13조(영상정보처리기기 설치·운영)
① < WegoLego >은(는) 아래와 같이 영상정보처리기기를 설치·운영하고 있습니다.

1.영상정보처리기기 설치근거·목적 : < WegoLego >의

2.설치 대수, 설치 위치, 촬영 범위 :
설치대수 : 대
설치위치 :
촬영범위 :
3.관리책임자, 담당부서 및 영상정보에 대한 접근권한자 :

4.영상정보 촬영시간, 보관기간, 보관장소, 처리방법
촬영시간 : 시간
보관기간 : 촬영시부터 년
보관장소 및 처리방법 :
5.영상정보 확인 방법 및 장소 :

6.정보주체의 영상정보 열람 등 요구에 대한 조치 : 개인영상정보 열람.존재확인 청구서로 신청하여야 하며, 정보주체 자신이 촬영된 경우 또는 명백히 정보주체의 생명.신체.재산 이익을 위해 필요한 경우에 한해 열람을 허용함

7.영상정보 보호를 위한 기술적.관리적.물리적 조치 :




제14조(개인정보 처리방침 변경)

 

① 이 개인정보처리방침은 2021년 11월 10부터 적용됩니다.

② 이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다.

예시 ) - 20XX. X. X ~ 20XX. X. X 적용 (클릭)

예시 ) - 20XX. X. X ~ 20XX. X. X 적용 (클릭)

예시 ) - 20XX. X. X ~ 20XX. X. X 적용 (클릭)''',
                  style:
                      TextStyle(color: Colors.white), // validator: validator,
                ),
              ),
            ),
            // actions: <Widget>[
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       new ElevatedButton(
            //         child: new Text(
            //           "확인",
            //           style:
            //               AppTextStyle.koBody2.copyWith(color: AppColors.grey),
            //         ),
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //         style: ElevatedButton.styleFrom(
            //           // padding: padding,
            //           primary: AppColors.grey[200],
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(33),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ],
          );
        });
  }

  Widget buildEmailTextFormFields() {
    return Column(
      children: [
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _nameController,
          hintText: '닉네임 ',
          validator: (value) {
            if (value.toString().length <= 2) {
              return '2자리 이상 입력해주세요. ';
            } else if (value.toString().length >= 7) {
              return '6글자 이하로 입력해주세요';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _emailController,
          hintText: '이메일 ',
          validator: (value) {
            bool _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!);
            if (!_isEmailValid) {
              return '유효하지 않은 이메일 양식입니다. ';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _passwordController,
          obsecureText: true,
          hintText: '비밀번호 ',
          validator: (value) {
            if (value.toString().length < 6) {
              return '비밀번호는 6자리 이상으로 설정해주세요. ';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          obsecureText: true,
          hintText: '비밀번호 확인 ',
          validator: (value) {
            if (value.trim() != _passwordController.text.trim()) {
              return '비밀번호가 일치하지 않습니다. ';
            }

            return null;
          },
        ),
      ],
    );
  }

  Widget buildNotEmailTextFormFields() {
    return Column(
      children: [
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _nameController,
          hintText: '닉네임 ',
          validator: (value) {
            if (value.toString().length <= 2) {
              return '2자리 이상 입력해주세요. ';
            } else if (value.toString().length >= 7) {
              return '6글자 이하로 입력해주세요';
            }
            return null;
          },
        ),
      ],
    );
  }
}
