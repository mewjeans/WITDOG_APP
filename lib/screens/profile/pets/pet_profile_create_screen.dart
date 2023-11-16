import 'package:flutter/material.dart';
import 'package:pet/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PetProfileCreateScreen extends StatefulWidget {
  final String userId;

  PetProfileCreateScreen({required this.userId});

  @override
  _PetProfileCreateScreenState createState() => _PetProfileCreateScreenState();
}

class _PetProfileCreateScreenState extends State<PetProfileCreateScreen> {
  final _nameController = TextEditingController();
  final _brithController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> savePetProfile() async {
    final name = _nameController.text;
    final birth = _brithController.text;
    final breed = _breedController.text;
    final age = _ageController.text;
    final phone = _phoneController.text;

    try {
      final user = supabase.auth.currentUser;

      if (user != null) {
        final userId = user.id;
        final response = await supabase.from('pet_profiles').upsert([
          {
            'user_id': userId,
            'pet_name': name,
            'birth_date': birth,
            'breed': breed,
            'pet_age': age,
            'pet_phone': phone,
          },
        ]);

        if (response != null) {
          if (response.error != null) {
            print('펫 프로필 저장 실패: ${response.error!.message}');
          } else {
            print('펫 프로필 저장 성공');
          }
        }
      } else {
        print('펫 프로필 저장 중에 문제가 발생했습니다. 응답이 null입니다.');
      }
    } catch (e) {
      // 디버깅을 위해 예외에 대한 자세한 정보 출력
      print('savePetProfile 동안 예외 발생: $e');
      if (e is PostgrestException) {
        print('PostgrestException details: ${e.details}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반려 프로필'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '반려 이름'),
            ),
            TextField(
              controller: _brithController,
              decoration: InputDecoration(labelText: '생년월일'),
            ),
            TextField(
              controller: _breedController,
              decoration: InputDecoration(labelText: '품종'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: '나이'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: '반려 번호'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: savePetProfile,
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
