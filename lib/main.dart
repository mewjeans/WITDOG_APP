import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:pet/provider/auth_provider.dart';
import 'package:pet/screens/profile/pets/pet_profile_list_screen.dart';
import 'package:pet/screens/video_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:pet/screens/auth/login_screen.dart';
import 'package:pet/screens/chat_screen.dart';
import 'package:pet/screens/home_screen.dart';
import 'package:pet/screens/profile/users/user_profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  KakaoSdk.init(nativeAppKey: '8af072c461ea48f446fa772d0662a93e');
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeDateFormatting('ko-KR', null);

  await Supabase.initialize(
      url: 'https://jyhwpcbuqfulfbydevff.supabase.co',
      anonKey:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5aHdwY2J1cWZ1bGZieWRldmZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg3NTgxNzksImV4cCI6MjAxNDMzNDE3OX0.eg3CNGiqr8sqSG0Ci7J45HgdtmgYGka4dV-CcV5HZKY');
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
        '/my': (context) => UserProfileScreen(),
        '/chat': (context) => ChatScreen(),
        '/login': (context) => LoginScreen(),
        '/pet': (context) => PetProfileListScreen(),
        '/videoCall': (context) => VideoHomeScreen(),
      },
      home: LoginScreen(),
    );
  }
}
