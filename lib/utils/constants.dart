import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// supabase client
final supabase = Supabase.instance.client;

/// Simple sized box to space out form elements
const formSpacer = SizedBox(width: 16, height: 16);

const preloader =
Center(child: CircularProgressIndicator(color: Colors.orange));

// Error message to display the user when unexpected error occurs.
const unexpectedErrorMessage = 'Unexpected error occured.';


// Set of extension methods to easily display a snackbar
extension ShowSnackBar on BuildContext {
  // Displays a basic snackbar
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  // Displays a red snackbar indicating error
  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}