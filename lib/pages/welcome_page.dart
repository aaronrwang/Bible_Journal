import 'package:bible_journal/pages/login_page.dart';
import 'package:bible_journal/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Lottie.asset('assets/lotties/welcome.json', repeat: false),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupPage();
                        },
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(
                      100.0,
                      40.0,
                    ),
                  ),
                  child: Text('Sign Up'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(
                      100.0,
                      40.0,
                    ),
                  ),
                  child: Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
