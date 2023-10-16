import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pet/provider/auth_provider.dart';
import 'package:pet/screens/video_call_screen.dart';
import 'package:pet/screens/video_index_screen.dart';
import 'package:provider/provider.dart';
import 'package:pet/screens/auth/login_screen.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/home_screen.dart';
import 'package:pet/screens/my_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {

  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDateFormatting("ko-KR", null);

  await Supabase.initialize(
      url: "https://tjrejzrorrititvqyfab.supabase.co",
      anonKey:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqcmVqenJvcnJpdGl0dnF5ZmFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTU2MzUyMTcsImV4cCI6MjAxMTIxMTIxN30.h8jrB4moK_U5uVmr_vW1FuRwebwwCyPjLpUJmNrSPvA");
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/my': (context) => MyProfile(),
        '/chat': (context) => ChatScreen(),
        '/login': (context) => LoginScreen(),
        '/videoIndex': (context) => VideoIndexScreen(),
        '/videoCall': (context) => VideoCallScreen(),
      },
      home: LoginScreen(),
    );
  }
}
