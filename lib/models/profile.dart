import 'dart:convert';
import 'dart:typed_data';

class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.email,
    required this.images,
  });

  final String id;
  final String username;
  final String email;

  // 이미지 데이터를 위한 Uint8List
  final Uint8List images;

  // 프로필 생성된 날짜 및 시간
  final DateTime createdAt;

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        username = map['username'] ?? '',
        email = map['email'] ?? '',
        images = _decodeImages(map['images'] ?? ''),
        createdAt = map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(); // 'createdAt'이 null인 경우 현재 시간으로 설정

  static Uint8List _decodeImages(String base64String){
    return base64Decode(base64String);
  }
}
