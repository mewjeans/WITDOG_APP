import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenPageState createState() => RegisterScreenPageState();
}

class RegisterScreenPageState extends State<RegisterScreen> {
  bool _isLoading = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
        data: {'username' : _nameController.text.toLowerCase()},
      );

      // 회원가입이 성공하면 로그인 화면으로 이동
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } catch (error) {
      // 에러 처리 추가
      print('회원 가입 오류: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF3FDE8),
        body:
        Container(
          key: _formKey,
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/logo/WITDOG_Logo.png'),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: '이메일',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: BorderSide(
                                      color: Colors.lightGreen),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '이메일을 입력하세요.';
                                }
                                final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return '올바른 이메일 형식이 아닙니다.';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            autofocus: false,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: '비밀번호',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(
                                    color: Colors.lightGreen),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            obscureText: true,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '비밀번호를 입력하세요.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: '이름',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(
                                    color: Colors.lightGreen),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '이름을 입력하세요.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              minimumSize: const Size(double.infinity, 50), // 너비를 화면 너비로 설정
                              backgroundColor: const Color(0xFFA8DF8E),
                            ),
                            onPressed: () {
                              if (!_isLoading) {
                                _signUp();
                              }
                            },
                            child: const Text(
                              '회원가입',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ]
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}

