import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:show_your_month/main.dart';
import 'package:show_your_month/mypage/my_page.dart';
import 'package:show_your_month/plantStorage/storage_page.dart';
import 'package:show_your_month/plantpage/plant_page.dart';

enum ThemeStyle {
  Dribbble,
  Light,
  NoElevation,
  AntDesign,
  BorderRadius,
  FloatingBar,
  NotificationBadge,
  WithTitle,
  BlurEffect
}

class navigation_page extends StatefulWidget {
  // navigation_page({required Key key, required this.title}) : super(key: key);

  // final String title;

  @override
  _navigation_pageState createState() => _navigation_pageState();
}

class _navigation_pageState extends State<navigation_page> {
  final List<Widget> _children = [
    HomePage(),
    plant_page(),
    storage_Page(),
    my_page()
  ];
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  var _currentIndex = 0;
  ThemeStyle _currentStyle = ThemeStyle.NotificationBadge;

  List<int> _badgeCounts = List<int>.generate(4, (index) => index);

  List<bool> _badgeShows = List<bool>.generate(4, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      extendBody: true,
      backgroundColor: Colors.white,

      body: _children[_currentIndex],
      bottomNavigationBar: _buildTitle(),
    );
  }

  Widget _buildTitle() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Colors.black87,
      strokeColor: Color(0x30040307),
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
    );
  }

  // 네비게이션 바 디자인 종류

  // Widget _buildBottomNavigationBar() {
  //   switch (_currentStyle) {
  //     case ThemeStyle.Dribbble:
  //       return _buildOriginDesign();
  //     case ThemeStyle.Light:
  //       return _buildLightDesign();
  //     case ThemeStyle.AntDesign:
  //       return _buildCustomIconDesign();
  //     case ThemeStyle.BorderRadius:
  //       return _buildBorderRadiusDesign();
  //     case ThemeStyle.FloatingBar:
  //       return _buildFloatingBar();
  //     case ThemeStyle.NoElevation:
  //       return _buildNoElevation();
  //     case ThemeStyle.NotificationBadge:
  //       return _buildNotificationBadge();
  //     case ThemeStyle.WithTitle:
  //       return _buildTitle();
  //     case ThemeStyle.BlurEffect:
  //       return _buildBlurEffect();
  //     default:
  //       return _buildOriginDesign();
  //   }
  // }

  Widget _buildNotificationBadge() {
    print("notification");
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Color(0xff317113),
      strokeColor: Color(0x30040307),
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
          badgeCount: _badgeCounts[0],
          showBadge: _badgeShows[0],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          badgeCount: _badgeCounts[1],
          showBadge: _badgeShows[1],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          badgeCount: _badgeCounts[2],
          showBadge: _badgeShows[2],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.search),
          badgeCount: _badgeCounts[3],
          showBadge: _badgeShows[3],
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          badgeCount: _badgeCounts[4],
          showBadge: _badgeShows[4],
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _badgeShows[index] = false;
        });
      },
    );
  }

  Widget _buildOriginDesign() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: Color(0xff6c788a),
      backgroundColor: Color(0xff040307),
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.search),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildLightDesign() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Color(0xff040307),
      strokeColor: Color(0x30040307),
      unSelectedColor: Color(0xffacacac),
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.search),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildNoElevation() {
    return CustomNavigationBar(
      elevation: 0.0,
      iconSize: 30.0,
      selectedColor: Color(0xff625aff),
      strokeColor: Color(0xff625aff),
      unSelectedColor: Colors.white,
      backgroundColor: Color(0xffa9a5f2),
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.search),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.account_circle),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildCustomIconDesign() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Color(0xff0c18fb),
      strokeColor: Color(0x300c18fb),
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.home,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.shoppingcart,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.cloudo,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.search1,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.user,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildBorderRadiusDesign() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Color(0xff0c18fb),
      strokeColor: Color(0x300c18fb),
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      borderRadius: Radius.circular(20.0),
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.home,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.shoppingcart,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.cloudo,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.search1,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.user,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildFloatingBar() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Color(0xff0c18fb),
      strokeColor: Color(0x300c18fb),
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      borderRadius: Radius.circular(20.0),
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.home,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.shoppingcart,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.cloudo,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.search1,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.user,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      isFloating: true,
    );
  }

  Widget _buildBlurEffect() {
    return CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.black,
      borderRadius: Radius.circular(20.0),
      blurEffect: true,
      opacity: 0.8,
      items: [
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.home,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.shoppingcart,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.cloudo,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.search1,
          ),
        ),
        CustomNavigationBarItem(
          icon: Icon(
            AntDesign.user,
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      isFloating: true,
    );
  }
}
