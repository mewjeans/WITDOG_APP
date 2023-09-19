import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FDE8),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(// 유효성 검사를 위한 키 설정
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
                              borderSide: BorderSide(color: Colors.lightGreen),
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
                            // 정규 표현식을 사용하여 이메일 형식 유효성 검사 수행
                            final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return '올바른 이메일 형식이 아닙니다.';
                            }
                            return null; // 유효성 검사 통과
                          },
                          onSaved: (value) => {}
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
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
                            borderSide: BorderSide(color: Colors.lightGreen),
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
                        onChanged: (value) {

                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '비밀번호를 입력하세요.';
                          }
                          // 비밀번호 복잡성에 대한 유효성 검사를 추가하려면 여기에 코드를 추가하세요.
                          return null; // 유효성 검사 통과
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
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
                            borderSide: BorderSide(color: Colors.lightGreen),
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
                        onChanged: (value) {
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '이름을 입력하세요.';
                          }
                          // 다른 이름 유효성 검사 규칙을 추가하려면 여기에 코드를 추가하세요.
                          return null; // 유효성 검사 통과
                        },
                      ),

                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          minimumSize: const Size(400, 50),
                          backgroundColor: const Color(0xFFA8DF8E),
                        ),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}