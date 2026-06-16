import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gpt_clone/design/app_colors.dart';
import 'package:gpt_clone/features/chat/chat.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset('assets/logo.svg', color: Colors.white),
            ),
            Text(
              'Welcome to Chatgpt',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.pinkBgColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'We believe our research will eventually lead to artificial general intelligence, a system that can solve human-level problems.',
                style: TextStyle(fontSize: 16, color: AppColors.pinkBgColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              elevation: WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                  side: BorderSide(color: AppColors.pinkBgColor),
                ),
              ),
              // elevation:
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chat()),
              );
            },
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Try chatgpt',
                  style: TextStyle(fontSize: 16, color: AppColors.pinkBgColor),
                  textAlign: TextAlign.center,
                ),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
