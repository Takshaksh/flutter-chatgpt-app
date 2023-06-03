import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/utils/assets_manager.dart';
import 'package:flutter_chatgpt/src/utils/colors.dart';
import 'package:flutter_chatgpt/src/utils/dimens.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  late TextEditingController messageTextEditingController;

  @override
  void initState() {
    messageTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: Dimens.paddingSmall,
          child: ClipRRect(
            borderRadius: Dimens.radiusLarge,
            child: Image.asset(AssetsManager.openaiLogo),
          ),
        ),
        title: const Text("Flutter ChatGPT"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Rang.textColor,
            ),
          )
        ],
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const Text("This is a text");
                },
              )),
              if (_isTyping) ...[
                const SpinKitThreeBounce(
                  color: Rang.primaryColor,
                  size: 20,
                )
              ],
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Rang.cardColor,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 0, 4),
                        child: TextField(
                          style: const TextStyle(color: Rang.textColor),
                          controller: messageTextEditingController,
                          decoration: const InputDecoration(
                            hintText: "How may I help you?",
                            hintStyle: TextStyle(color: Rang.hintTextColor),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            // TODO: Enter submit login here
                          },
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Send button tapped");
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Rang.textColor,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
