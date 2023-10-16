import 'package:flutter/material.dart';
import 'package:pet/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  Future<void> login(String email, String password, BuildContext context) async {
    setLoading(true);

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('password', password);

        _navigateToHome(context);
      } else {
        print('로그인 실패: ${response.toString()}');
      }
    } catch (error) {
      print('일반 오류: $error');
    } finally {
      setLoading(false);
    }
  }
}

