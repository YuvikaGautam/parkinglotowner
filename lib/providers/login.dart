import 'package:flutter/material.dart';
import 'package:parkinglotowner/providers/loginWithmail.dart';
import 'package:parkinglotowner/providers/register.dart';
import 'package:parkinglotowner/utilities/appBar.dart';
import 'package:parkinglotowner/utilities/button.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:parkinglotowner/utilities/social.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 31),
          child: Column(children: [
            Text(
              'Let’s you in',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            SocialSignInButton(
              text: 'Sign in with Google',
              image: 'assests/images/google.png',
              onPressed: () {
                // Add sign-in with Google logic here
              },
            ),
            SizedBox(
              height: 20,
            ),
            SocialSignInButton(
              text: 'Sign in with Facebook',
              image: 'assests/images/facebook.png',
              onPressed: () {
                // Add sign-in with Facebook logic here
              },
            ),
            SizedBox(
              height: 20,
            ),
            SocialSignInButton(
              text: 'Sign in with WhatsApp',
              image: 'assests/images/whatsapp.png',
              onPressed: () {
                // Add sign-in with Apple logic here
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("or"),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginEmail()));
              },
              text: 'Continue with Email',
            ),
          ]),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: InkWell(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account? ',
                  style: TextStyle(
                    fontSize: 16,
                    color: grey,
                  ),
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    color: bluecolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ),
    );
  }
}