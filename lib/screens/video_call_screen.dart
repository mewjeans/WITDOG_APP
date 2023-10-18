import 'package:flutter/cupertino.dart';
import 'package:pet/utils/constants.dart';
import 'package:pet/utils/settings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatefulWidget{
  final String callId;

  const VideoCallScreen({
    Key? key,
    required this.callId
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen>{
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 1289136985,
        appSign: '041dfa8f63e9276c76cdd354e4d391d35e1733e5d8db34f99fddaa8df13108cc',
        userID: localUserId,
        userName: 'user_$localUserId',
        callID: widget.callId,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              /// in minimizing
              ZegoUIKitPrebuiltCallMiniOverlayMachine()
                  .changeState(PrebuiltCallMiniOverlayPageState.idle);
            } else {
              Navigator.of(context).pop();
            }
          }

        /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ],
      ),
    );
  }
}