import 'package:flutter/material.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/profile/pets/pet_profile_list_screen.dart';
import 'package:pet/screens/video_home_screen.dart';
import 'package:pet/widgets/service_guide_dialog.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;

          if (screenWidth > 600) {
            return buildTabletLayout(context);
          } else {
            return buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PetProfileListScreen()));
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

  Widget buildTabletLayout(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 320,
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
              crossAxisCount: 4,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PetProfileListScreen()));
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
