import 'package:flutter/material.dart';
import 'package:pet/screens/register_screen.dart';
import 'package:pet/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _autoLogin();

  }

  _autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {
      _emailController.text = savedEmail;
      _passwordController.text = savedPassword;

      // 자동 로그인 시도
      _signIn();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (response.user != null) {
          // 로그인에 성공하면 SharedPreferences에 사용자 데이터 저장
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _emailController.text);
          prefs.setString('password', _passwordController.text);

          print('로그인 성공');
          _navigateToHome();
        } else {
          // 로그인에 실패한 경우 적절한 오류 처리
          print('로그인 실패: ${response.toString()}');
        }
      } catch (error) {
        print('일반 오류: $error');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FDE8),
      body: Center(
        child: SingleChildScrollView(
          child: _buildLoginForm(context),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/logo/WITDOG_Logo.png'),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력하세요.';
                  }
                  return null;
                },
                onSaved: (value) => {},
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  errorStyle: const TextStyle(color: Colors.red),
                  fillColor: Colors.white,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  }
                  return null;
                },
                onSaved: (value) => {

                },
              ),
            ),
            SizedBox.fromSize(
              size: const Size(0, 10),
            ),
            _buildLoginButton(context),
            SizedBox.fromSize(
              size: const Size(0, 5),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30.0, top: 8.0),
                  child: Text('아직 계정이 없으신가요?'),
                ),
                const Spacer(),
                _buildRegisterButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signIn,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        minimumSize: const Size(100, 40),
        backgroundColor: const Color(0xFFA8DF8E),
      ),
      child: _isLoading
          ? const CircularProgressIndicator() // 로딩 중에는 로딩 인디케이터 표시
          : const Text(
        '로그인',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        minimumSize: const Size(170, 40),
        backgroundColor: const Color(0xFFA8DF8E),
      ),
      child: const Text(
        '회원가입',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
