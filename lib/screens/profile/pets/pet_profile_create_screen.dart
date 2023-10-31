import 'package:flutter/material.dart';

class PetProfileCreateScreen extends StatefulWidget {
  @override
  _PetProfileCreateScreenState createState() => _PetProfileCreateScreenState();
}

class _PetProfileCreateScreenState extends State<PetProfileCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반려 프로필 생성'),
      ),
      body: Center(
        child: Text('반려 프로필 생성 화면입니다.'),
      ),
    );
  }
}
