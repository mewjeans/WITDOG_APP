import 'package:flutter/material.dart';
import 'package:pet/widgets/service_guide_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: buildDrawer(context),
      appBar: AppBar(
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
      ),
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
                color: Color(0xFFF3FDE8), // Card 색상 설정
                child: InkWell(
                  onTap: () {
                    // 컨테이너를 탭했을 때 다이어로그 실행
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
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

            SizedBox(height: 16), // 이미지와 그리드 사이 간격 조절

            // 그리드로 카드 아이템 배치
            GridView.count(
              crossAxisCount: 2, // 2열로 배치
              shrinkWrap: true, // 그리드 크기를 내용에 맞게 조절
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
                        // 카드 아이템을 탭했을 때 수행할 동작 추가
                      },
                      child: Container(
                        alignment: Alignment.center, // 이미지를 수평 및 수직으로 중앙 정렬
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
                        // 카드 아이템을 탭했을 때 수행할 동작 추가
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
                        // 카드 아이템을 탭했을 때 수행할 동작 추가
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
                        // 카드 아이템을 탭했을 때 수행할 동작 추가
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/image/dogList_image.png',
                              width: 100, height: 100),
                          Text(
                            '반려 목록',
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

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY',
          ),
        ],
        selectedItemColor: Color(0xFFA8DF8E),
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
                '메뉴', // '메뉴' 텍스트 색상 변경
                style: TextStyle(
                  color: Colors.white, // 텍스트 색상을 흰색으로 변경
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

          // 사진보기 아이템
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


  void handleMenuItemClick(String selectedItem) {
    print("Selected item: $selectedItem");
  }
}
