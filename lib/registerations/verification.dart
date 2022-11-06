import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/registerations/waiting.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:provider/provider.dart';

class Verification extends StatefulWidget {
  int encoded;
  Verification(this.encoded, {super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  File? image;

  late String imageTemp2;
  Future pickImageC() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 75);

      if (image == null) return;

      final imageTemp = File(image.path);
      final bytes = File(image.path).readAsBytesSync();
      imageTemp2 = const Base64Encoder().convert(bytes);
      print(imageTemp2);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                color: Colors.black,
                child: const Text("Capture Image from Camera",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  pickImageC();
                }),
            image != null ? Image.file(image!) : Text("No image Captured"),
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {
                image != null
                    ? sendVerification(imageTemp2, widget.encoded)
                        .then((value) async {
                        if (value == true) {
                          // await context.read<AuthProvider>().imageSubmitted();
                          // await context.read<AuthProvider>().;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Waiting(),
                            ),
                          );
                        }
                      })
                    : Text("No image Captured");
              },
              icon: Icon(Icons.upload_file),
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
