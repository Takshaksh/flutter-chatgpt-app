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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  chatIndex == 0 ? AssetsManager.userImage : AssetsManager.botImage,
                  width: 32,
                  height: 32,
                ),

                const SizedBox(width: 8),

                Expanded(child: Text(msg)),

                chatIndex == 0 
                  ? const SizedBox.shrink() 
                  : const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.thumb_up_rounded, color: Rang.textColor,),
                      SizedBox(width: 6),
                      Icon(Icons.thumb_down_rounded, color: Rang.textColor,)
                    ],
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
