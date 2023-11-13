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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 220,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color:  Color(0xFFF3FDE8).withOpacity(1.0),
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
                    padding: const EdgeInsets.all(1),
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
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            children: [
              buildCard(
                context,
                '언어 번역',
                'assets/image/dogLang_image.png',
                ServiceGuideDialog(),
              ),
              buildCard(
                context,
                '채팅',
                'assets/image/chat_image.png',
                ChatScreen(),
              ),
              buildCard(
                context,
                '영상 통화',
                'assets/image/video_chat_image.png',
                VideoHomeScreen(),
              ),
              buildCard(
                context,
                '반려 프로필',
                'assets/image/dogList_image.png',
                PetProfileListScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCard(
      BuildContext context, String title, String imagePath, Widget route) {
    return Card(
      color: Color(0xFFF3FDE8),
      elevation: 1.5,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return route;
          }));
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 100, height: 100),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTabletLayout(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          backgroundColor: Colors.transparent,  // 투명한 색상으로 설정
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
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
                    padding: const EdgeInsets.all(20.0),
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
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(25),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            children: [
              buildCard(
                context,
                '챗 커뮤니티',
                'assets/image/dogLang_image.png',
                ChatScreen(),
              ),
              buildCard(
                context,
                '영상 통화',
                'assets/image/video_chat_image.png',
                VideoHomeScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
