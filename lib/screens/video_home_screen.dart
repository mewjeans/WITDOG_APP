import 'package:flutter/material.dart';
import 'package:pet/screens/video_call_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoHomeScreen extends StatelessWidget {
  /// Users who use the same callID can in the same call.
  final callIDTextCtrl = TextEditingController(text: "call_id");

  VideoHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: callIDTextCtrl,
                  decoration:
                  const InputDecoration(labelText: "join a call by id"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (ZegoUIKitPrebuiltCallMiniOverlayMachine().isMinimizing) {
                    /// when the application is minimized (in a minimized state),
                    /// disable button clicks to prevent multiple PrebuiltCall components from being created.
                    return;
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return VideoCallScreen(callId: callIDTextCtrl.text);
                    }),
                  );
                },
                child: const Text("join"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}