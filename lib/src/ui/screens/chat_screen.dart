
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/data/models/quary_parameters.dart';
import 'package:flutter_chatgpt/src/data/providers/common_providers.dart';
import 'package:flutter_chatgpt/src/ui/widgets/chat_widget.dart';
import 'package:flutter_chatgpt/src/ui/widgets/drop_down.dart';
import 'package:flutter_chatgpt/src/utils/assets_manager.dart';
import 'package:flutter_chatgpt/src/utils/colors.dart';
import 'package:flutter_chatgpt/src/utils/dimens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../utils/constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  late TextEditingController promptTextEditingController;

  @override
  void initState() {
    promptTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTyping = ref.watch(isLoadingProvider);
    final selectedModel = ref.watch(selectedModelProvider);
    final messages = ref.watch(messagesProvider);

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
          TextButton(
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
            child: const Row(
              children: [
                // Icon(
                //   Icons.arrow_right_rounded,
                //   color: Rang.textColor,
                // ), 
                Text("👉 Select Model 👈", style: TextStyle(color: Rang.textColor, fontWeight: FontWeight.bold),)
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              if(messages.isEmpty)
                Expanded( child: Image.asset(AssetsManager.askAnything, height: 200, width: 200,))
              else
                Flexible(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        msg: messages[index].msg,
                        chatIndex: messages[index].chatIndex,
                      );
                    },
                  )
                ),
              if (isTyping) ...[
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
                          controller: promptTextEditingController,
                          decoration: const InputDecoration(
                            hintText: "Eg. What is Riverpod?",
                            hintStyle: TextStyle(color: Rang.hintTextColor),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        String prompt = promptTextEditingController.text;

                        if(selectedModel.isEmpty){
                          Fluttertoast.showToast(msg: "Please select a model.");
                          return;
                        }

                        if(prompt.isNotEmpty){
                          ref.read(messagesProvider.notifier).addMessage(prompt, 1);

                          try {
                            ref.read(isLoadingProvider.notifier).state = true;
                            final result = await ref.watch(sendQueryProvider(QueryParameters(model: selectedModel, prompt: prompt)).future);

                            ref.read(messagesProvider.notifier).addMessage(result.choices.first.text.trimLeft(), result.choices.first.index);

                            promptTextEditingController.clear();
                            log("Completion data ChatScreen: index: ${result.choices.first.index} reply: ${result.choices.first.text}");
                            ref.read(isLoadingProvider.notifier).state = false;
                          } catch (error) {
                            log("Error in ChatScreen: ${error.toString()}");
                            Fluttertoast.showToast(msg: error.toString());
                          }
                        }else{
                          Fluttertoast.showToast(msg: "Please type something.");
                        }
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
