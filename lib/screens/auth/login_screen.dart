import 'package:flutter/material.dart';
import 'package:pet/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FDE8),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/logo/WITDOG_Logo.png'),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: '이메일',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.lightGreen),
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
                  validator: (value) =>
                  value!.isEmpty ? 'ID와 비밀번호가 올바르지 않습니다.' : null,
                  onSaved: (value) =>{}
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: const BorderSide(color: Colors.lightGreen),
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
                      return '아이디 및 패스워드가 틀렸습니다.';
                    }
                    return null;
                  },
                  onSaved: (value) =>{}

                ),
              ),
              SizedBox.fromSize(
                size: const Size(0, 10),
              ),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0), // 둥근 모서리 설정
                  ),
                  minimumSize: const Size(100, 40),
                  backgroundColor: const Color(0xFFA8DF8E),
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox.fromSize(
                size: const Size(0, 5),
              ),
              const Text(
                '로그인 하셨나요?',
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 8.0), // 상단으로 조금 올림
                    child: Text("아직 계정이 없으신가요?"),
                  ),
                  const Spacer(), // 오른쪽 끝까지 간격 채우기
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(), // 회원가입 페이지로 이동
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(40.0), // 둥근 모서리 설정
                      ),
                      minimumSize: const Size(170, 40), // 버튼 크기 설정
                      backgroundColor: const Color(0xFFA8DF8E),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}