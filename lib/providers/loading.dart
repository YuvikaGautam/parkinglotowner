import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.black,
          color: Colors.white,
        ),
      ),
    );
  }
}
