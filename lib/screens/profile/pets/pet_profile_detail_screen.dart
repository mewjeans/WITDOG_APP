import 'package:flutter/material.dart';
import 'package:pet/screens/routing/routing_helper.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';

class PetProfileDetailScreen extends StatefulWidget {
  final Map<String, dynamic> petProfile;

  // 생성자를 통해 petProfile을 받아옵니다.
  PetProfileDetailScreen({required this.petProfile});

  @override
  _PetProfileDetailScreenState createState() =>
      _PetProfileDetailScreenState(petProfile: petProfile);
}

class _PetProfileDetailScreenState extends State<PetProfileDetailScreen> {
  final int _selectedIndex = 3; // 초기 선택 인덱스
  final bool _appBarVisible = true;
  bool _showProfile = false;

  final Map<String, dynamic> petProfile;

  // 상태 클래스 생성자에서 petProfile을 받아옵니다.
  _PetProfileDetailScreenState({required this.petProfile});

  // 바텀 네비게이션 아이템이 탭될 때 호출되는 메서드
  void _onItemTapped(int index) {
    routingHelper(context, index, _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushNamedAndRemoveUntil(
          context,
          '/pet',
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '반려 프로필',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/pet',
                    (route) => false,
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: bottomNavBarItems,
          onTap: _onItemTapped,
          selectedItemColor: Color(0xFF6ABFB9),
          showUnselectedLabels: _appBarVisible,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
        ),
        body: Column(
          children: [
            Container(
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
                      color: Color(0xFFD4ECEA),
                      size: 100,
                    ),
                    Positioned(
                      top: 65,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF6ABFB9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF6ABFB9),
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
            Row(
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
                    subtitle: Text(petProfile['pet_name'] ?? ''),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('생년월일'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text(petProfile['birth_date'] ?? ''),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('반려견 품종'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text(petProfile['breed'] ?? ''),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('반려견 나이'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text(petProfile['pet_age'].toString()+' 살' ?? ''),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('반려 전화번호'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text(petProfile['pet_phone'].toString() ?? ''),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
