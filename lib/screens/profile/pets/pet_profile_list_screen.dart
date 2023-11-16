import 'package:flutter/material.dart';
import 'package:pet/screens/profile/pets/pet_profile_create_screen.dart';
import 'package:pet/screens/profile/pets/pet_profile_detail_screen.dart';
import 'package:pet/screens/routing/routing_helper.dart';
import 'package:pet/utils/constants.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetProfileListScreen extends StatefulWidget {
  @override
  _PetProfileListScreenState createState() => _PetProfileListScreenState();
}

class _PetProfileListScreenState extends State<PetProfileListScreen> {
  final int _selectedIndex = 3;
  final bool _appBarVisible = true;
  final user = supabase.auth.currentUser;
  bool _showProfile = false;

  // 반려동물 프로필을 저장할 리스트 정의
  List<Map<String, dynamic>> petProfiles = [];

  // 반려동물 프로필을 Supabase에서 가져오는 함수
  Future<void> fetchPetProfiles() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final userId = user.id;

      final response =
          await supabase.from('pet_profiles').select().eq('user_id', userId);
      print(response);
      if (response is List && response.isNotEmpty) {
        setState(() {
          petProfiles = List<Map<String, dynamic>>.from(response);
        });
      } else {
        print('반려동물 프로필을 가져오지 못했습니다: $response');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // 위젯 초기화 시 반려동물 프로필을 가져오도록 함
    fetchPetProfiles();
  }

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
          selectedItemColor: Color(0xFF6ABFB9),
          showUnselectedLabels: _appBarVisible,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
        ),
        body: CustomScrollView(
          slivers: [
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
                    // 반려동물 프로필을 표시
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: petProfiles.length,
                      itemBuilder: (context, index) {
                        print(
                            'Building item $index'); // Add this line for debugging
                        var profile = petProfiles[index];
                        return InkWell(
                          onTap: () {
                            // 클릭 시 디테일 화면으로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PetProfileDetailScreen(petProfile: profile),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(profile['pet_name'] ?? ''),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(profile['pet_phone'] ?? ''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                height: MediaQuery.of(context).size.width - 300, // 높이를 설정할 부분
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetProfileCreateScreen(userId: ''),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
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
            ),
          ],
        ),
      ),
    );
  }
}
