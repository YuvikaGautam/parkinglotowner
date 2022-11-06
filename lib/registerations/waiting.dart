import 'package:flutter/material.dart';


class Waiting extends StatefulWidget {
  const Waiting({super.key});

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Under Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
           Icon(Icons.hourglass_top, size: 100, color: Colors.black),
            SizedBox(height: 20),
            Text('Verification in progress', style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}