
// Data models list
import 'package:flutter/material.dart';

List<String> dataModels = [
  'ChatGPT 4',
  'ChatGPT 3',
  'Google Bard',
  'Alexa GPT',
  'BOSS GPT'
];

List<DropdownMenuItem<String>>? get getDataModelItems{
  List<DropdownMenuItem<String>>? dataModelItems = List<DropdownMenuItem<String>>.generate(
    dataModels.length, 
    (index) => DropdownMenuItem(
      value: dataModels[index],
      child: Text(
        dataModels[index]
      )
    )
  );

  return dataModelItems;
}


// Chat placeholder messages
final chatMessages = [
  {
    "msg": "Hello!",
    "chatIndex": 0
  },
  {
    "msg": "How are you?",
    "chatIndex": 1
  },
  {
    "msg": "Nice weather today!",
    "chatIndex": 0
  },
  {
    "msg": "What's your favorite color?",
    "chatIndex": 1
  },
  {
    "msg": "I don't wanna talk about my favourite color, I'm hungry and I want to eat something good. And I don't wanna eat a small snack, it should be heavy.",
    "chatIndex": 0
  },
  {
    "msg": "Do you like pizza?",
    "chatIndex": 1
  },
  {
    "msg": "I'm going for a walk.",
    "chatIndex": 0
  },
  {
    "msg": "How is the pizza did you enjoyed eating it?",
    "chatIndex": 1
  },
  {
    "msg": "Goodnight!",
    "chatIndex": 0
  },
  {
    "msg": "See you tomorrow!",
    "chatIndex": 1
  }
];

class Constants{
  // Sharedpreferences constants
  static const prefToken = 'token';
  static const prefModels = 'models';
}