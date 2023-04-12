import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:parkinglotowner/utilities/appBar.dart';
import 'package:parkinglotowner/utilities/button.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({super.key});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  File? _image;
  String imageString = '';

  Future _getImage() async {
    try {
      final pickedImage = await ImagePicker().getImage(
        imageQuality: 75,
        source: ImageSource.camera,
      );

      if (pickedImage == null) return;

      final imageTemp = File(pickedImage.path);
      final bytes = File(pickedImage.path).readAsBytesSync();
      imageString = const Base64Encoder().convert(bytes);
      print(imageString);
      setState(() {
        _image = File(pickedImage.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool result = await uploadImg(authProvider.userId, imageString);
    if (result) {
      Future.delayed(const Duration(seconds: 3), () {
        AuthProvider().underVerifyProcess = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your verification is under review.'),
          ),
        );
        Navigator.of(context).pop;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Verification',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          )),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    // height: 200,
                    // width: 200,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.camera_alt, size: 100),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _getImage,
              text: 'Take a picture',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: _image == null ? null : _submit,
              text: 'Submit',
            ),
          ],
        ),
      )),
    );
  }
}
