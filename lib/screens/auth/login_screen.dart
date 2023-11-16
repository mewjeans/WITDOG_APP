import 'package:flutter/material.dart';
import 'package:pet/gen/assets.gen.dart';
import 'package:pet/provider/auth_provider.dart';
import 'package:pet/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart' as provider;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _isLoading = false;
  late bool _shouldValidate = false;

  // 위젯 빌드 외부에서 폼 상태에 액세스하기 위한 새로운 키
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _autoLogin();

  }

  void _autoLogin() async {
    var prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {
      _emailController.text = savedEmail;
      _passwordController.text = savedPassword;

      // 자동 로그인 시도
      final authProvider = provider.Provider.of<AuthProvider>(context, listen: false);
      await authProvider.login(_emailController.text, _passwordController.text, context);

    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
            Assets.logo.wITDOGLogo.image(),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Color(0xFF6ABFB9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Color(0xFF6ABFB9)),
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
                  } else if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return '유효한 이메일 주소를 입력하세요.';
                  }
                  return null;
                },

              ),
            ),
            _buildErrorTextWidget(),

            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Color(0xFF6ABFB9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: Color(0xFF6ABFB9)),
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
                    } else if (value.length < 6) {
                      return '비밀번호는 최소 6자 이상이어야 합니다.';
                    }
                    return null;
                }
              ),
            ),

            SizedBox.fromSize(
              size: const Size(0, 10),
            ),
            _buildLoginButton(context),
            SizedBox.fromSize(
              size: const Size(0, 5),
            ),
            _buildKakaoLoginButton(context),
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

  Widget _buildErrorTextWidget() {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (_shouldValidate && !_formKey.currentState!.validate()) {
            // 검증 오류 처리
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '입력한 정보가 올바르지 않습니다.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _shouldValidate = false; // 로그인 실패 시 검증 비활성화
            });
          }
        });
        return SizedBox.shrink();
      },
    );
  }


  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () {
        setState(() {
          _shouldValidate = true; // 로그인 시 검증을 활성화
        });
        if (_formKey.currentState!.validate()) {
          final authProvider = provider.Provider.of<AuthProvider>(context, listen: false);
          authProvider.login(
            _emailController.text,
            _passwordController.text,
            context,
          );
        } else {
          setState(() {
            _shouldValidate = false; // 로그인 실패 시 검증 비활성화
          });
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        minimumSize: const Size(100, 40),
        backgroundColor: const Color(0xFF6ABFB9),
      ),
      child: _isLoading
          ? const CircularProgressIndicator() // 로딩 중에는 로딩 인디케이터 표시
          : const Text(
              '로그인',
              style: TextStyle(fontSize: 20.0),
            ),
    );
  }

  Widget _buildKakaoLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : () async {
        // 카카오 로그인 시도
        final authProvider = provider.Provider.of<AuthProvider>(context, listen: false);
        await authProvider.kakaologin(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0), // 모서리를 둥글게 깍는 부분
        ),
        child: ClipRRect( // 모서리 둥글게 깍는데 사용
          borderRadius: BorderRadius.circular(40.0),
          child: Assets.logo.kakaoLogin.image(
            height: 40,
            fit: BoxFit.cover, // 이미지를 부모 컨테이너에 맞게 늘리기
          ),
        ),
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
        backgroundColor: const Color(0xFF6ABFB9),
      ),
      child: const Text(
        '회원가입',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
