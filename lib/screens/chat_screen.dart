import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet/models/message.dart';
import 'package:pet/models/profile.dart';
import 'package:pet/utils/constants.dart';
import 'package:timeago/timeago.dart';

class ChatScreen extends StatefulWidget {

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => ChatScreen(),
    );
  }

  @override
  State<ChatScreen> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatScreen> {
  late Stream<List<Message>> _messagesStream;
  final Map<String, Profile> _profileCache = {};
  late final TextEditingController _textController;

  @override
  void initState() {
    final myUserId = supabase.auth.currentUser!.id;
    _messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps
        .map((map) => Message.fromMap(map: map, myUserId: myUserId))
        .toList());

    _textController = TextEditingController();
    super.initState();
  }

  Future<void> _loadProfileCache(String profileId) async {
    if (_profileCache[profileId] != null) {
      return;
    }
    final data =
    await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);
    setState(() {
      _profileCache[profileId] = profile;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('채팅',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFF3FDE8),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _MessageBar(
              onSendMessage: _sendMessage, // 콜백 설정
            ), // _MessageBar 수정
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<Message>>(
      stream: _messagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('데이터를 불러오는 중 오류 발생: ${snapshot.error}');
        }

        // ConnectionState.active 또는 ConnectionState.done일 때 데이터를 출력
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          final messages = snapshot.data ?? [];

          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              _loadProfileCache(message.profileId);
              return _ChatBubble(
                message: message,
                profile: _profileCache[message.profileId],
              );
            },
          );
        }

        // 위의 조건 외에도 return 문을 사용하여 기본 Widget 반환
        return const Center(child: Text('데이터를 불러오는 중...'));
      },
    );
  }

  void _sendMessage(String text) async {
    final myUserId = supabase.auth.currentUser!.id;
    final now = DateTime.now();
    final formattedDate = now.toUtc().toIso8601String();

    await supabase.from('messages').upsert([
      {
        'profile_id': myUserId,
        'content': text,
        'created_at': formattedDate,
      },
    ]);
    _textController.clear();
  }
}

class _MessageBar extends StatefulWidget {
  final void Function(String) onSendMessage;

  const _MessageBar({
    Key? key,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  State<_MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<_MessageBar> {
  late final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: true,
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // 메시지 보내기
                  final text = _textController.text;
                  if (text.isNotEmpty) {
                    widget.onSendMessage(text);
                    _textController.clear();
                  }
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    Key? key,
    required this.message,
    required this.profile,
  }) : super(key: key);

  final Message message;
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    var chatContents = <Widget>[
      if (!message.isMine)
        CircleAvatar(
          child: profile == null
              ? preloader
              : Text(profile!.username.substring(0, 2)),
        ),
      const SizedBox(width: 12),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content),
        ),
      ),
      const SizedBox(width: 12),
      Text(format(message.createdAt, locale: 'en_short')),
      const SizedBox(width: 60),
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
        message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
