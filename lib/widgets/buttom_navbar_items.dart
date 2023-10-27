import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> bottomNavBarItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.chat),
    label: '채팅',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'MY',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.pets_outlined),
    label: '펫 프로필',
  ),
];
