import 'package:flutter/material.dart';
import 'package:pet/screens/auth/login_screen.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/home_screen.dart';
import 'package:pet/screens/my_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: '[My_SUPABASE_URL]',
    anonKey: '[My_SUPABASE_ANON_KEY]',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // 변경: 초기 경로를 '/'로 설정
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/my': (context) => MyProfile(),
        '/chat': (context) => ChatScreen()
      },
      home: LoginScreen(),
    );
  }
}
