
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/ui/widgets/chat_widget.dart';
import 'package:flutter_chatgpt/src/ui/widgets/drop_down.dart';
import 'package:flutter_chatgpt/src/utils/assets_manager.dart';
import 'package:flutter_chatgpt/src/utils/colors.dart';
import 'package:flutter_chatgpt/src/utils/dimens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends ConsumerState<ChatScreen> {
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
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                backgroundColor: Rang.backgroundColor,
                shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
                builder: (context) {
                  return Container(
                    width: double.infinity,
                    height: 210,
                    padding: Dimens.paddingMedium,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: const BoxDecoration(
                            color: Rang.cardBackgroundColor,
                            borderRadius: Dimens.radiusMedium,
                          ),
                          child: const SizedBox(width: 64, height: 1),
                        ),
                        const SizedBox(height: 16,),
                        const Text(
                          "👇 Choose a model 👇",
                          style: TextStyle(color: Rang.textColor, fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(height: 12,),

                        const Flexible(
                          child: ModelDropDownWidget()
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Rang.primaryColor),
                              foregroundColor: const MaterialStatePropertyAll(Rang.textColor),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 4, horizontal: 6))
                            ),
                            child: const Text("Okay"),
                          ),
                        )
                      ],
                    ),
                  );
                }
              );
            },
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index]['msg'].toString(),
                    chatIndex: int.parse(chatMessages[index]['chatIndex'].toString()),
                  );
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
                color: Rang.cardBackgroundColor,
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
                      onPressed: () async {
                        Fluttertoast.showToast(msg: "Send button tapped");
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Rang.textColor,
                      )
                   )
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
