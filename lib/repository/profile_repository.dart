import 'dart:convert';
import 'dart:io';

import 'package:pet/utils/constants.dart';

Future<void> saveProfileToDatabase(String userId, String email, String username, DateTime createdAt) async {
  try {
    final response = await supabase.from('profiles').upsert([
      {
        'id' : userId,
        'email': email,
        'username': username,
        'created_at': createdAt.toIso8601String(),
      }
    ]);
    print(response);

    if (response.error != null) {
      // 에러 처리
      print('프로필 데이터 저장 오류: ${response.error!.message}');
    } else {
      // 성공적으로 데이터 저장
      print('프로필 데이터가 성공적으로 저장되었습니다.');
    }
  } catch (error) {
    // 에러 처리
    print('프로필 데이터 저장 중 오류 발생: $error');
  }
}

// 사용자의 프로필 이미지를 저장
Future<void> saveProfileWithImageToDatabase(String userId ,File imageFile) async {
  try {
    List<int> imageBytes = await imageFile.readAsBytes();
    final imageUrl = 'data:image/jpeg;base64,${base64Encode(imageBytes)}';

    print('Image URL: $imageUrl');

    final response = await supabase.from('images').upsert([
      {
        'user_id': userId,
        'image_data': imageUrl,
      }
    ]);

    if (response.error != null) {
      // 에러 처리
      print('프로필 및 이미지 데이터 저장 오류: ${response.error!.message}');
    } else {
      // 성공적으로 데이터 저장
      print('프로필 및 이미지 데이터가 성공적으로 저장되었습니다.');
    }
  } catch (error) {
    // 에러 처리
    print('프로필 및 이미지 데이터 저장 중 오류 발생: $error');
  }
}
