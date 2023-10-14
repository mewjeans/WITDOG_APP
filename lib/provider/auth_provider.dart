import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // 로그인 메서드
  Future<void> login(String email, String password) async {
    setLoading(true);
    // TODO : login_screen 에있는 로그인 로직을 여기로 옮겨야함

    setLoading(false);
  }
}
