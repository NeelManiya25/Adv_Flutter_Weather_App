import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class intro_page extends StatefulWidget {
  const intro_page({super.key});

  @override
  State<intro_page> createState() => _intro_pageState();
}

class _intro_pageState extends State<intro_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome to Weather app ",
            body:
                "Welcome to Weather app. This is a description of how it Redding.",
            image: Center(
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/originals/75/16/ea/7516ea5454d6ebb256d2ecb34b66a95c.gif'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
        ],
        done: Text("done"),
        onDone: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("isIntroVisited", true);
          Navigator.pushReplacementNamed(context, 'SplashScreen');
        },
        next: Text("Next"),
        showNextButton: true,
      ),
    );
  }
}
