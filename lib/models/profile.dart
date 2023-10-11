class Profile{
  Profile({
    required this.id,
    required this.username,
    required this.createdAt,
});
  // 프로필 사용자 id
  final String id;
  // 프로필 사용자 이름
  final String username;

  // 프로필 생성된 날짜 및 시간
  final DateTime createdAt;

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        createdAt = map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(); // 'createdAt'이 null인 경우 현재 시간으로 설정

}