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