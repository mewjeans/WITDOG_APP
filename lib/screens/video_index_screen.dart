import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:pet/screens/video_call_screen.dart';

class VideoIndexScreen extends StatefulWidget {
  @override
 _VideoIndexScreen createState() => _VideoIndexScreen();
}
enum  VideoSelect { videoCreate, videoAndChatCreate, videoConnect }

class _VideoIndexScreen extends State<VideoIndexScreen> {
  final _channelController = TextEditingController();
  VideoSelect? _videoSelect = VideoSelect.videoCreate;
  bool _validateError = false;
  ClientRoleType? _role;

  @override
  void initState() {
    super.initState();
    _channelController;
  }

  @override
  void dispose() {
    super.dispose();
    _channelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xFFF3FDE8),
        title: Text('영상 통화',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('assets/image/dog_video_call.png'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    hintText: '채널 이름',
                    errorText: _validateError ? '채널 이름을 입력하세요.' : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('영상 통화 생성'),
                leading: Radio<VideoSelect>(
                  value: VideoSelect.videoCreate,
                  groupValue: _videoSelect,
                  onChanged: (VideoSelect? value) {
                    setState(() {
                      _videoSelect = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('영상 통화 및 채팅 생성'),
                leading: Radio<VideoSelect>(
                  value: VideoSelect.videoAndChatCreate,
                  groupValue: _videoSelect,
                  onChanged: (VideoSelect? value) {
                    setState(() {
                      _videoSelect = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('영상 통화 접속'),
                leading: Radio<VideoSelect>(
                  value: VideoSelect.videoConnect,
                  groupValue: _videoSelect,
                  onChanged: (VideoSelect? value) {
                    setState(() {
                      _videoSelect = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _joinChannel,
                child: Text('채널 입장'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _joinChannel() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    if (_channelController.text.isNotEmpty) {
      if (mounted) {
        var statuses = await [
          Permission.camera,
          Permission.microphone,
        ].request();

        if (statuses[Permission.camera] == PermissionStatus.granted &&
            statuses[Permission.microphone] == PermissionStatus.granted) {
          // 권한이 부여되었을 때 실행해야 할 작업을 추가하세요.
          // 채널 입장 로직을 여기에 구현하세요.
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoCallScreen(
                  channelName: _channelController.text,
                  role: _videoSelect == VideoSelect.videoCreate ?
                  ClientRoleType.clientRoleBroadcaster :
                  ClientRoleType.clientRoleAudience
              ),
            ),
          );
        } else {
          openAppSettings(); // 앱 설정 열기
        }
      }
      await [Permission.camera, Permission.microphone].request();
    }
  }
}