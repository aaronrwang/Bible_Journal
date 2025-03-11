import 'package:bible_journal/widget_tree.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController =
      TextEditingController(text: '@nd.edu');
  TextEditingController passwordController = TextEditingController(text: '123');
  String confirmedEmail = '@nd.edu';
  String confirmedPassword = '123';
  @override
  void initState() {
    print('InitState');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                SizedBox(height: 20.0),
                FilledButton(
                  onPressed: () {
                    //TODO: authentication
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return WidgetTree();
                      },
                    ));
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
