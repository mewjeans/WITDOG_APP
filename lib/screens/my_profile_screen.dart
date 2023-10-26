import 'package:flutter/material.dart';

class MyProfileScreen extends StatelessWidget {
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
            '내 프로필',
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
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight:135,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Color(0xFFDDFFB8),
                      size: 100, // "account_circle" 아이콘 크기 조절
                    ),
                    Positioned(
                      top: 65, // "edit" 아이콘의 위쪽 여백 조절
                      right: 5, // "edit" 아이콘의 오른쪽 여백 조절
                      child: Container(
                        padding: EdgeInsets.all(5), // 테두리 주위에 여백 추가
                        decoration: BoxDecoration(
                          color: Color(0xFFA8DF8E),
                          borderRadius: BorderRadius.circular(10),
                          // 라운드된 모서리 설정
                          border: Border.all(
                            color: Color(0xFFA8DF8E),
                            width: 2, // 테두리 두께 설정
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.mode_edit_outline,
                              size: 17, // "edit" 아이콘 크기 조절
                              color: Colors.white, // "edit" 아이콘 색상 설정 (예: 빨간색)
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
                  fontSize: 16, // 텍스트 크기 조절
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
                  color: Color(0xFFA8DF8E), // 테두리 색상 설정
                  width: 1, // 테두리 두께 설정
                ),
                borderRadius: BorderRadius.circular(10), // 라운드된 모서리 설정
              ),
              child: Text(
                '프로필 관리',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Card(
              elevation: 2, // 카드의 그림자 높이 설정
              margin: EdgeInsets.all(30), // 카드 주위의 여백 설정
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    '프로필',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
}