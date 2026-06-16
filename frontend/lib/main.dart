import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpt_clone/design/app_theme.dart';
import 'package:gpt_clone/features/chat/bloc/chat_bloc.dart';
import 'package:gpt_clone/features/onbording/onboarding.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(),
      child: MaterialApp(
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const OnboardingPage(),
        builder: (context, child) =>
            SafeArea(bottom: true, top: false, child: child!),
      ),
    );
  }
}
