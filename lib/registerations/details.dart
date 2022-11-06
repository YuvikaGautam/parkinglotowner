import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/providers/login.dart';
import 'package:parkinglotowner/registerations/verification.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:provider/provider.dart';

class DetailsEntry extends StatefulWidget {
  const DetailsEntry({super.key});

  @override
  State<DetailsEntry> createState() => _DetailsEntryState();
}

generateID() {
  String adminId = ("BMPS " +
          DateTime.now().millisecondsSinceEpoch.hashCode.toString() +
          "@@" +
          FirebaseAuth.instance.currentUser!.uid)
      .hashCode
      .toString();
}

class _DetailsEntryState extends State<DetailsEntry> {
  // int encoded = base64.encode(utf8.encode(adminId)).hashCode;

  final _formKey = GlobalKey<FormState>();
  final FName = TextEditingController();
  final LName = TextEditingController();
  final ParkingLotName = TextEditingController();
  final ParkingLotAddress = TextEditingController();
  final ParkingManagerName = TextEditingController();
  final PhoneNumber = TextEditingController();
  final CarSpace = TextEditingController();
  final BikeSpace = TextEditingController();
  Future<void> bookingid() async {
    String adminId = ("BMPS " +
            DateTime.now().millisecondsSinceEpoch.hashCode.toString() +
            "@@" +
            FirebaseAuth.instance.currentUser!.uid)
        .hashCode
        .toString();
    int encoded = base64.encode(utf8.encode(adminId)).hashCode;
    print(encoded);
    await FirebaseFirestore.instance
        .collection("admins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "adminId": encoded,
    });
    bool result = await addAdmin(
        encoded,
        FName.text,
        LName.text,
        ParkingLotName.text,
        ParkingLotAddress.text,
        ParkingManagerName.text,
        int.parse(PhoneNumber.text),
        int.parse(CarSpace.text),
        int.parse(BikeSpace.text));

    if (result) {
     await context.read<AuthProvider>().detailsEntered(encoded);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Verification(encoded),
        ),
      );
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details Entry"),
          actions: [
            IconButton(
                onPressed: () async {
                  const CircularProgressIndicator();
                  await context.read<AuthProvider>().logout();
                  SnackBar snackBar = const SnackBar(
                    content: Text("Logged out successfully"),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * mainBdPadHoriz,
              vertical: size.width * mainBdPadVert,
            ),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildFName(),
                    buildLName(),
                    buildParkingLotName(),
                    buildParkingLotAddress(),
                    buildParkingManagerName(),
                    buildPhoneNumber(),
                    buildCarSpace(),
                    buildBikeSpace(),
                    MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.black,
                        onPressed: (() {
                          bool valid = _formKey.currentState!.validate();
                          if (valid) {
                            bookingid();
                          } else {
                            print('invalid');
                          }
                        }),
                        child: const Text('Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))
                  ],
                ))));
  }

  Widget buildFName() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: FName,
          validator: (value) {
            if (value!.isEmpty) {
              return "First Name cannot be empty";
            }
            if (value.length < 3) {
              return "First Name must be atleast 3 characters";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'First Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
  Widget buildLName() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: LName,
          validator: (value) {
            if (value!.isEmpty) {
              return "Last Name cannot be empty";
            }
            if (value.length < 3) {
              return "Last Name must be atleast 3 characters";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Last Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
  Widget buildCarSpace() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: CarSpace,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Car Space cannot be empty";
            }
            if (int.tryParse(value) == null) {
              return "Car Space must be a number";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Enter Car Space Available',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
  Widget buildBikeSpace() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: BikeSpace,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Bike Space cannot be empty";
            }
            if (int.tryParse(value) == null) {
              return "Bike Space must be a number";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Enter Bike Space Available',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
  Widget buildParkingManagerName() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: ParkingManagerName,
          validator: (value) {
            if (value!.isEmpty) {
              return "Parking Manager Name cannot be empty";
            }
            if (value.length < 3) {
              return "Parking Manager Name must be atleast 3 characters";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Enter Parking Manager Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
  Widget buildPhoneNumber() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: PhoneNumber,
          maxLength: 10,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Parking Lot Phone Number cannot be empty";
            }
            if (value.length < 10 || value.length > 10) {
              return "Enter valid Parking Lot Phone Number";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Enter Parking Lot Phone Number',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );

  Widget buildParkingLotName() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: ParkingLotName,
          validator: (value) {
            if (value!.isEmpty) {
              return "ParkingLot Name cannot be empty";
            }
            if (value.length < 3) {
              return "ParkingLot Name must be atleast 3 characters";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Enter ParkingLot Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
  Widget buildParkingLotAddress() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          controller: ParkingLotAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return "ParkingLot Address cannot be empty";
            }
            if (value.length < 3) {
              return "ParkingLot Address must be atleast 3 characters";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Enter ParkingLot Address',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      );
}
