import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';
import 'package:pet/widgets/route_names.dart';

class PetProfileScreen extends StatefulWidget{
  @override
  _PetProfileScreenState createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  int _selectedIndex = 3; // 초기 선택 인덱스
  final bool _appBarVisible = true;

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
            '펫 프로필',
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
          unselectedLabelStyle: TextStyle(
              color: Colors.grey
          ),
        ),
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 135,
                minWidth: MediaQuery
                    .of(context)
                    .size
                    .width,
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
            Container(
              child: Text(
                '홍길동',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFF3FDE8),
                border: Border.all(
                  color: Color(0xFFA8DF8E),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '프로필 관리',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Card(
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
                    subtitle: Text('홍길동'),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('이메일'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text('test@test.com'),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('가입일'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text('2023-10-26'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, RouteNames.routeNames[index]);
    });
  }
}
