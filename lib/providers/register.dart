import 'package:flutter/material.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/providers/login.dart';
import 'package:parkinglotowner/registerations/details.dart';
import 'package:parkinglotowner/utilities/appBar.dart';
import 'package:parkinglotowner/utilities/button.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
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
                  'Create Your Account',
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bluecolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bluecolor),
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
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: bluecolor,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: bluecolor),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    filled: true,
                    fillColor: Color.fromRGBO(217, 217, 217, 0.5),
                    hintText: 'Password',
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bluecolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
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
                  height: 20,
                ),
                TextFormField(
                  obscureText: _isObscure2,
                  controller: confirmpassController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: bluecolor,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure2
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: bluecolor),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        }),
                    filled: true,
                    fillColor: Color.fromRGBO(217, 217, 217, 0.5),
                    hintText: 'Confirm Password',
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bluecolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: bluecolor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (confirmpassController.text != passwordController.text) {
                      return "Password did not match";
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
                      signUp(emailController.text, passwordController.text);
                    },
                    text: 'Sign Up'),
                SizedBox(height: 16),
                loading ? CircularProgressIndicator() : Container(),
              ]),
            )),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: InkWell(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontSize: 16,
                    color: grey,
                  ),
                ),
                Text(
                  'Sign In',
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    setState(() {
      loading = true;
    });
    if (_formkey.currentState!.validate()) {
      String result =
          await context.read<AuthProvider>().signUp(email, password);
      if (result == "Signed up successfully!") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Details()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      }
    }
    setState(() {
      loading = false;
    });
  }
}