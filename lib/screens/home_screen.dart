import 'package:flutter/material.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/profile/users/user_profile_screen.dart';
import 'package:pet/screens/profile/pets/pet_profile_screen.dart';
import 'package:pet/screens/routing/routing_helper.dart';
import 'package:pet/screens/video_home_screen.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';
import 'package:pet/widgets/route_names.dart';
import 'package:pet/widgets/service_guide_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final bool _appBarVisible = true; // AppBar 표시 여부를 관리하는 변수 추가

  void _onItemTapped(int index) {
    routingHelper(context, index, _selectedIndex);
  }

  void _performLogout(BuildContext context) async {
    // 로그아웃 시 사용자 데이터를 초기화하고 로그인 화면으로 이동
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');

    // 여기에 로그아웃 이후의 동작을 추가할 수 있습니다.
    // 예를 들어, 로그인 화면으로 이동하거나 다른 작업을 수행하는 등...

    await Navigator.pushNamedAndRemoveUntil(
        context, '/login', (Route<dynamic> route) => false);
  }

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(),
    ChatScreen(),
    UserProfileScreen(),
    PetProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: buildDrawer(context),
      appBar: _appBarVisible ? AppBar( // _appBarVisible 상태에 따라 AppBar 표시 여부 결정
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
      ) : null,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: bottomNavBarItems,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFA8DF8E),
        showUnselectedLabels: _appBarVisible,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
        color: Colors.grey
        ),
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
                color: Color(0xFFA8DF8E),
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
              print('홈 눌림');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              color: Colors.grey[850],
            ),
            title: Text('사진보기'),
            onTap: () {
              print('사진보기 눌림');
              Navigator.pop(context);
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey[850],
            ),
            title: Text('로그아웃'),
            onTap: () {
              _performLogout(context);
            }
          )
        ],
      ),
    );
  }

  void handleMenuItemClick(String selectedItem) {
    print('Selected item: $selectedItem');
  }
}

class HomeScreenContent extends StatelessWidget {
  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFA8DF8E),
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
              print('홈 눌림');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              color: Colors.grey[850],
            ),
            title: Text('사진보기'),
            onTap: () {
              print('사진보기 눌림');
              Navigator.pop(context);
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              color: Color(0xFFF3FDE8),
              child: Card(
                elevation: 1.5,
                color: Color(0xFFF3FDE8),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ServiceGuideDialog();
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/image/main_image.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 15, right: 15),
              children: [
                Container(
                  width: 200,
                  height: 120,
                  child: Card(
                    color: Color(0xFFF3FDE8),
                    elevation: 1.5,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ServiceGuideDialog();
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/image/dogLang_image.png',
                                width: 100, height: 100),
                            Text(
                              '언어 번역',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 120,
                  child: Card(
                    color: Color(0xFFF3FDE8),
                    elevation: 1.5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/chat_image.png',
                              width: 100, height: 100),
                          Text(
                            '채팅',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 120,
                  child: Card(
                    color: Color(0xFFF3FDE8),
                    elevation: 1.5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return VideoHomeScreen();
                        }));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/video_chat_image.png',
                              width: 100, height: 100),
                          Text(
                            '영상 통화',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 120,
                  child: Card(
                    color: Color(0xFFF3FDE8),
                    elevation: 1.5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PetProfileScreen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/dogList_image.png',
                              width: 100, height: 100),
                          Text(
                            '반려 프로필',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
