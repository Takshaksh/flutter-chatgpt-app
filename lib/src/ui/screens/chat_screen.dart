
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/utils/assets_manager.dart';

class ChatScreen extends StatefulWidget{
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }

}

class _ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter ChatGPT"),),
      body: Center(
        child: Image.asset(AssetsManager.botImage),
      ),
    );
  }

}