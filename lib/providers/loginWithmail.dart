import 'package:flutter/material.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/providers/register.dart';
import 'package:parkinglotowner/screen/home.dart';
import 'package:parkinglotowner/utilities/appBar.dart';
import 'package:parkinglotowner/utilities/button.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:provider/provider.dart';

class LoginEmail extends StatefulWidget {
  LoginEmail({super.key});

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool _isObscure3 = true;
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 31),
          child: Form(
            key: _formkey,
            child: Column(children: [
              Text(
                'Login to your Account',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: bluecolor,
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(217, 217, 217, 0.5),
                  hintText: 'Email',
                  enabled: true,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluecolor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluecolor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid email");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isObscure3,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: bluecolor,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure3 ? Icons.visibility_off : Icons.visibility,
                          color: bluecolor),
                      onPressed: () {
                        setState(() {
                          _isObscure3 = !_isObscure3;
                        });
                      }),
                  filled: true,
                  fillColor: Color.fromRGBO(217, 217, 217, 0.5),
                  hintText: 'Password',
                  enabled: true,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluecolor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bluecolor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  RegExp regex = RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  if (!regex.hasMatch(value)) {
                    return ("please enter valid password min. 6 character");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                onPressed: () {
                  signIn(emailController.text, passwordController.text);
                },
                text: 'Sign In',
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(height: 16),
              loading ? CircularProgressIndicator() : Container(),
              Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("or continue with"),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Image.asset('assests/images/google.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assests/images/facebook.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assests/images/whatsapp.png'),
                    onPressed: () {},
                  ),
                ],
              )
            ]),
          ),
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
            // Navigate to the login screen
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    setState(() {
      loading = true;
    });
    if (_formkey.currentState!.validate()) {
      String result = await context.read<AuthProvider>().login(email, password);

      if (result == "Login success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result),
        ));
      }
    }
    setState(() {
      loading = false;
    });
  }
}
