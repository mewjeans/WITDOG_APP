import 'package:flutter/material.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/home_screen_content.dart';
import 'package:pet/screens/profile/users/user_profile_screen.dart';
import 'package:pet/screens/profile/pets/pet_profile_list_screen.dart';
import 'package:pet/screens/routing/routing_helper.dart';
import 'package:pet/screens/video_home_screen.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';
import 'package:pet/widgets/service_guide_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;
  final bool _appBarVisible = true; // AppBar 표시 여부를 관리하는 변수 추가

  void _onItemTapped(int index) {
    routingHelper(context, index, _selectedIndex);
  }

  void _performLogout(BuildContext context) async {
    // 로그아웃 시 사용자 데이터를 초기화하고 로그인 화면으로 이동
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');

    // 로그아웃 이후의 동작을 추가
    await Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(),
    ChatScreen(),
    UserProfileScreen(),
    PetProfileListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: buildDrawer(context),
      appBar: _appBarVisible
          ? AppBar(
              // _appBarVisible 상태에 따라 AppBar 표시 여부 결정
              iconTheme: IconThemeData(color: Colors.grey),
              backgroundColor: Colors.white,
              toolbarHeight: 65,
              title: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/logo/WITDOG_Logo.png',
                      width: 130,
                      height: 100,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.grey,
                        size: 30,
                      ),
                    );
                  },
                ),
                SizedBox(width: 15),
              ],
            )
          : null,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: bottomNavBarItems,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF6ABFB9),
        showUnselectedLabels: _appBarVisible,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6ABFB9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey[850],
            ),
            title: Text('홈'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.grey[850],
              ),
              title: Text('로그아웃'),
              onTap: () {
                _performLogout(context);
              })
        ],
      ),
    );
  }

  void handleMenuItemClick(String selectedItem) {
    print('Selected item: $selectedItem');
  }
}

