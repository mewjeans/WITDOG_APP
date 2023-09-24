import 'package:flutter/material.dart';
import 'package:pet/screens/home_screen.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // When the back button is pressed, go to 'HomeScreen' and prevent the back action.
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home', // home screen path
              (route) => false, // remove all previous routes from the stack
        );
        return false; // Prevent back button action
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '마이 프로필',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home',(route) => false);
            },
          ),
        ),
        body: Center(
          child: Text('프로필'),
        ),
      ),
    );
  }
}

