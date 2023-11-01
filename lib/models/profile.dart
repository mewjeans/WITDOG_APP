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
  final String images;

  // 프로필 생성된 날짜 및 시간
  final DateTime createdAt;

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        username = map['username'] ?? '',
        email = map['email'] ?? '',
        images = map['images'] ?? '',
        createdAt = map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(); // 'createdAt'이 null인 경우 현재 시간으로 설정
}
