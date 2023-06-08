import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/utils/assets_manager.dart';
import 'package:flutter_chatgpt/src/utils/colors.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: chatIndex == 0 ? Rang.backgroundColor : Rang.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? AssetsManager.botImage : AssetsManager.avatarAstronaut,
                  width: 32,
                  height: 32,
                ),

                const SizedBox(width: 8),

                Expanded(
                  // child: Text(msg)
                  child: Padding(
                    padding: chatIndex == 1 ? const EdgeInsets.only(top: 6) : const EdgeInsets.only(top: 0),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(msg, speed: const Duration(milliseconds: 20), cursor: '█'),
                      ],
                    ),
                  ),
                ),

                chatIndex == 0 
                  ? const SizedBox.shrink() 
                  : const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.thumb_up_rounded, color: Rang.textColor,),
                        SizedBox(width: 6),
                        Icon(Icons.thumb_down_rounded, color: Rang.textColor,)
                      ],
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
