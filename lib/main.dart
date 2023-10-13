import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pet/screens/auth/login_screen.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/home_screen.dart';
import 'package:pet/screens/my_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async{
    var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await initializeDateFormatting("ko-KR", null);

    await Supabase.initialize(
        url: "https://tjrejzrorrititvqyfab.supabase.co",
        anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqcmVqenJvcnJpdGl0dnF5ZmFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTU2MzUyMTcsImV4cCI6MjAxMTIxMTIxN30.h8jrB4moK_U5uVmr_vW1FuRwebwwCyPjLpUJmNrSPvA");
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // 변경: 초기 경로를 '/'로 설정
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/my': (context) => MyProfile(),
        '/chat': (context) => ChatScreen(),
        '/login': (context) => LoginScreen(),
      },
      home: LoginScreen(),
    );
  }
}
