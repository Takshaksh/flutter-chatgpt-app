import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/ui/screens/chat_screen.dart';
import 'package:flutter_chatgpt/src/utils/colors.dart';
import 'package:flutter_chatgpt/src/utils/dimens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ChatGPT',
      theme: ThemeData(
          scaffoldBackgroundColor: Rang.backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Rang.primaryColor),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Rang.primaryTextColor),
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              color: Rang.primaryColor,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Rang.primaryTextColor,
                fontSize: Dimens.fontSizeLarge
              ))),
      home: const ChatScreen(),
    );
  }
}