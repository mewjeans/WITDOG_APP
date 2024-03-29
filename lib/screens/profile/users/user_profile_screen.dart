import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/repository/profile_repository.dart';
import 'package:pet/screens/routing/routing_helper.dart';
import 'package:pet/utils/constants.dart';
import 'package:pet/widgets/buttom_navbar_items.dart';
import 'package:pet/widgets/fetch_profile_image.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final int _selectedIndex = 2; // 초기 선택 인덱스
  final bool _appBarVisible = true;

  // 사용자 정보를 담을 변수 설정
  String email = '';
  String username = '';
  String createdAt = '';
  bool _loading = false;

  // 프로필 이미지
  File? _image;
  String imageUrl = '';
  Uint8List? _imageBytes;
  final picker = ImagePicker();

  final user = supabase.auth.currentUser;

  Future<void> _uploadImageAndSaveProfile() async {
    // 이미지가 선택되었을 때, 이미지를 업로드하고 프로필을 저장합니다.
    if (_image != null) {
      final userId = user!.id; // 현재 사용자 ID
      await saveProfileWithImageToDatabase(userId, _image!); // 이미지를 업로드하고 저장
    }
  }

  Future<void> _fetchAndUpdateImage() async {
    final userId = user!.id;
    final profileImage = await fetchProfileImage(userId);

    print('Profile Image: $profileImage');

    if (profileImage != null && profileImage.isNotEmpty) {
      // "data:image/jpeg;base64," 부분을 제거
      final imageDataWithoutPrefix = profileImage.split(',').last;
      print('이미지 디코딩 : $base64Decode(imageDataWithoutPrefix)');

      try {
        final bytes = base64Decode(imageDataWithoutPrefix);

        setState(() {
          _imageBytes = bytes;
        });

        print('Image fetched and assigned successfully');
      } catch (e) {
        print('Error fetching and updating image: $e');
        print('Error decoding base64 image: $e');
      }
    } else {
      print('Image fetch failed or empty.');
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      print('이미지를 선택하지 않았습니다.');
      return;
    }

    setState(() {
      _image = File(pickedFile.path);
    });

    _uploadImageAndSaveProfile();
    _fetchAndUpdateImage();
  }

  @override
  void initState() {
    super.initState();
    _initProfile(); // 사용자 정보 가져오기
  }

  Future<void> _initProfile() async {
    await _getProfile();
    await _fetchAndUpdateImage();
  }

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final user = supabase.auth.currentUser;

      if (user != null) {
        final userId = user.id;
        final response = await supabase
            .from('profiles')
            .select<Map<String, dynamic>>()
            .eq('id', userId)
            .single();
        final createdAtISO =
            response['created_at'] as String; // 가입일 데이터(ISO 형식)
        final createdAtd = DateTime.parse(createdAtISO);
        final formattedDate =
            "${createdAtd.year}-${createdAtd.month.toString().padLeft(2, '0')}-${createdAtd.day.toString().padLeft(2, '0')}";

        setState(() {
          username = response['username'] as String;
          email = response['email'] as String;
          createdAt = formattedDate;
          imageUrl = response['images'] as String;
        });

        await _fetchAndUpdateImage();
      }
    } catch (error) {
      print('에러: $error'); // 에러 로그 출력
      if (error is UnimplementedError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    routingHelper(context, index, _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final userId = user!.id;
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
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: 135,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDDFFB8),
                        shape: BoxShape.circle,
                      ),
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFFFFFFF),
                        backgroundImage: _imageBytes != null
                          ? MemoryImage(Uint8List.fromList(_imageBytes!))
                          : AssetImage('assets/icon/default_user_icon.png') as ImageProvider),
                    ),
                    if (_image != null)
                      Positioned(
                        child: GestureDetector(
                            onTap: () async {},
                            child: buildProfileImage(userId)),
                      ),
                    if (imageUrl.isEmpty || _image == null)
                      Positioned(
                        top: 65,
                        right: 5,
                        child: GestureDetector(
                          onTap: getImage,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Color(0xFF6ABFB9),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF6ABFB9),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(
                username,
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
                color: Color(0xFF6ABFB9),
                border: Border.all(
                  color: Color(0xFF6ABFB9),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '프로필 관리',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
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
                    subtitle: Text(username),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('이메일'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text(email),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text('가입일'),
                        SizedBox(width: 40),
                      ],
                    ),
                    subtitle: Text(createdAt),
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
