import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet/utils/constants.dart';

Future<String?> fetchProfileImage(String userId) async {
  final response = await supabase.from('images')
      .select('image_data').eq('user_id', userId).single();

  if (response != null) {
    final imageData = response['image_data'] as String?;
    return imageData;
  } else {
    return null;
  }
}

// 불러온 이미지 데이터를 디코딩하고 Image 위젯에 적용
Widget buildProfileImage(String? imageData) {
  if (imageData != null && imageData.isNotEmpty) {
    final bytes = base64Decode(imageData);
    return Image.memory(bytes, fit: BoxFit.cover);
  } else {
    // 이미지가 없을 때 기본적으로 표시할 위젯
    return Icon(Icons.account_circle, size: 100, color: Colors.white);
  }
}
