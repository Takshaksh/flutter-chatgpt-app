import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/ui/screens/chat_screen.dart';
import 'package:flutter_chatgpt/src/utils/colors.dart';
import 'package:flutter_chatgpt/src/utils/dimens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyChatGptApp(),));
}

class MyChatGptApp extends ConsumerWidget {
  const MyChatGptApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter ChatGPT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Rang.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Rang.primaryColor),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Rang.textColor),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Rang.primaryColor,
          titleTextStyle: TextStyle(
            color: Rang.textColor,
            fontSize: Dimens.fontSizeLarge
          )
        )
      ),
      home: const ChatScreen(),
    );
  }
}
