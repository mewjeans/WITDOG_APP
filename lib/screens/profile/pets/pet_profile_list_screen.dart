import 'package:flutter/material.dart';
import 'package:pet/screens/profile/pets/pet_profile_create_screen.dart';
import 'package:pet/screens/routing/routing_helper.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';

class PetProfileListScreen extends StatefulWidget {
  @override
  _PetProfileListScreenState createState() => _PetProfileListScreenState();
}

class _PetProfileListScreenState extends State<PetProfileListScreen> {
  final int _selectedIndex = 3; // 초기 선택 인덱스
  final bool _appBarVisible = true;
  bool _showProfile = false;

  void _onItemTapped(int index) {
    routingHelper(context, index, _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '반려 목록',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: bottomNavBarItems,
          onTap: _onItemTapped,
          selectedItemColor: Color(0xFFA8DF8E),
          showUnselectedLabels: _appBarVisible,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 135,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Color(0xFFDDFFB8),
                        size: 100,
                      ),
                      Positioned(
                        top: 65,
                        right: 5,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFA8DF8E),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFA8DF8E),
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.mode_edit_outline,
                                size: 17,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '수정하기 | ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '삭제하기',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 2,
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ListTile(
                      title: Row(
                        children: [
                          Text('이름'),
                          SizedBox(width: 40),
                        ],
                      ),
                      subtitle: Text('반려이름'),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text('생년월일'),
                          SizedBox(width: 40),
                        ],
                      ),
                      subtitle: Text('2023년 10월 22일'),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text('반려견 품종'),
                          SizedBox(width: 40),
                        ],
                      ),
                      subtitle: Text('시츄'),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text('반려견 나이'),
                          SizedBox(width: 40),
                        ],
                      ),
                      subtitle: Text('4살'),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetProfileCreateScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  minimumSize: Size(MediaQuery.of(context).size.width - 60, 135),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 40,
                      color: Color(0xFFA8DF8E),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
