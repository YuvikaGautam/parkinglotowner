import 'package:flutter/material.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/screen/home.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:parkinglotowner/utilities/button.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();
  final fName = TextEditingController();
  final lName = TextEditingController();
  final parkingLotName = TextEditingController();
  final parkingLotAddress = TextEditingController();
  final parkingManagerName = TextEditingController();
  final phoneNumber = TextEditingController();
  final carSpace = TextEditingController();
  final bikeSpace = TextEditingController();
  bool result = false;

  Future<bool> addAdmin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    result = await addAdminDetails(
        authProvider.userId,
        fName.text,
        lName.text,
        parkingLotName.text,
        parkingLotAddress.text,
        parkingManagerName.text,
        int.parse(phoneNumber.text),
        int.parse(carSpace.text),
        int.parse(bikeSpace.text));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 31),
          child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fill Your Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Column(
                    children: [
                       Center(
                        child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: grey,
                              child: const Icon(Icons.person,
                                  size: 75,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: buildfName(),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: buildlName(),
                                  ),
                                ],
                              ),
                              buildparkingLotName(),
                              buildparkingLotAddress(),
                              buildparkingManagerName(),
                              buildphoneNumber(),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildcarSpace(),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: buildbikeSpace(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              CustomButton(
                                onPressed: (() async {
                                  bool valid =
                                      _formKey.currentState!.validate();
                                  if (valid) {
                                    await addAdmin();
                                    if (result) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Identity Verification Required')));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Something went wrong')));
                                    }
                                  }
                                }),
                                text: 'Continue',
                              ),
                            ],
                          ))
                    ],
                  )
                ]),
              ))),
    );
  }

  Widget buildfName() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: fName,
          validator: (value) {
            if (value!.isEmpty) {
              return "First Name cannot be empty";
            }
            if (value.length < 3) {
              return "First Name must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('First Name'),
        ),
      );
  Widget buildlName() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: lName,
          validator: (value) {
            if (value!.isEmpty) {
              return "Last Name cannot be empty";
            }
            if (value.length < 3) {
              return "Last Name must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Last Name'),
        ),
      );
  Widget buildcarSpace() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
            controller: carSpace,
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
            decoration: getCustomDecoration('Car')),
      );
  Widget buildbikeSpace() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: bikeSpace,
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
          decoration: getCustomDecoration('Bike'),
        ),
      );
  Widget buildparkingManagerName() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: parkingManagerName,
          validator: (value) {
            if (value!.isEmpty) {
              return "Parking Manager Name cannot be empty";
            }
            if (value.length < 3) {
              return "Parking Manager Name must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Enter Parking Manager Name'),
        ),
      );
  Widget buildphoneNumber() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: phoneNumber,
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
          decoration: getCustomDecoration('Enter Parking Lot Phone Number'),
        ),
      );
  Widget buildparkingLotName() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: parkingLotName,
          validator: (value) {
            if (value!.isEmpty) {
              return "ParkingLot Name cannot be empty";
            }
            if (value.length < 3) {
              return "ParkingLot Name must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Enter ParkingLot Name'),
        ),
      );
  Widget buildparkingLotAddress() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: parkingLotAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return "ParkingLot Address cannot be empty";
            }
            if (value.length < 3) {
              return "ParkingLot Address must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Enter ParkingLot Address'),
        ),
      );
}
