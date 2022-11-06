import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
      
            SizedBox(height: 20),
            Text('Home', style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}