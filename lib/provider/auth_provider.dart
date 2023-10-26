import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:pet/screens/home_screen.dart';
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

  Future<void> kakaologin(BuildContext context) async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');

        // 카카오 사용자 정보 가져오기
        try {
          final user = await UserApi.instance.me();

          // 카카오 사용자 정보를 Supabase 데이터베이스에 저장
          //await _saveKakaoUserInfo(user);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(), // 홈 화면으로 이동
            ),
          );
        } catch (error) {
          print('카카오 사용자 정보 가져오기 실패: $error');
        }
      } catch (error) {
        print('카카오톡으로 로그인 실패: $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인 시도
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패: $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패: $error');
      }
    }
  }

// 카카오 사용자 정보를 Supabase 데이터베이스에 저장
/*  Future<void> _saveKakaoUserInfo(User user) async {
    // user.id: 사용자의 카카오 회원번호
    // user.kakaoAccount?.profile?.nickname: 사용자의 카카오 닉네임
    // user.kakaoAccount?.email: 사용자의 카카오 이메일 (이메일이 공개 설정되어 있는 경우에만 사용 가능)
    final userId = user.id;
    final nickname = user.kakaoAccount?.profile?.nickname;
    final email = user.kakaoAccount?.email;

    // Supabase 테이블에 사용자 정보 삽입
    final response = await supabase.from('kakao_users').upsert([
      {
        'user_id': userId,
        'nickname': nickname,
        'email': email,
      },
    ]).execute();

    if (response.error != null) {
      print('Supabase에 사용자 정보 저장 중 오류 발생: ${response.error!.message}');
    } else {
      print('사용자 정보가 성공적으로 Supabase에 저장되었습니다.');
    }

    // 여기에 Supabase 데이터베이스에 저장하는 코드를 추가하면 됩니다.
  }*/
}

