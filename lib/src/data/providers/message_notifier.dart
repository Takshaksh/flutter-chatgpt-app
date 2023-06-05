import 'package:flutter_chatgpt/src/data/models/message_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesNotifier extends StateNotifier<List<Message>>{
  MessagesNotifier() : super([]);

  void addMessage(String msg, int chatIndex){
    state = [...state, Message(msg: msg, chatIndex: chatIndex)];
  }
}