import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:parkinglotowner/utilities/appBar.dart';
import 'package:parkinglotowner/utilities/button.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../utilities/setting.dart';
import 'scanner.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _uniqueCodeController = TextEditingController();
  String uniqueCode = '';
  String checkoutId = '';
  Future<void> generateIds() async {
    String id1 = "";

    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    var charLength = chars.length;
    for (var i = 0; i < 14; i++) {
      id1 += chars[Random().nextInt(charLength)];
    }
    checkoutId = id1;
  }

  Future<void> _scanQRCode() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scanner()),
    );
    await generateIds();
    await updateTicketStatusUser(result, checkoutId);
    setState(() {
      uniqueCode = result;
      print('uniqueCode: $uniqueCode');
    });
  }

  @override
  void initState() {
    super.initState();

    // getAllTickets("qwe");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Parking Lot Owner',
          leading: Image.asset('assests/images/logo.png'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 2), () {
                setState(() {});
              });
            },
            child: FutureBuilder(
              future: Future.wait(
                  [getAvailibiltySpace("qwe"), getAllTickets("qwe")]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  final ticketDetails = snapshot.data![1];
                  final availibiltySpace = snapshot.data![0];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          // physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSlotCard(
                                    'Car', availibiltySpace['carSpace']),
                                _buildSlotCard(
                                    'Bike', availibiltySpace['bikeSpace']),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Check In / Check Out Users',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('Scan QR Code',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      )),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  CustomButton(
                                    onPressed: () async {
                                      await _scanQRCode();
                                    },
                                    text: 'QR Code Scanner',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Active Bookings',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            )),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: ticketDetails.length,
                          itemBuilder: (context, index) {
                            return _buildBookingCard(
                              userName: ticketDetails[index]["vehicleNumber"],

                              // vehicleType: 'Car',
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }

  Widget _buildSlotCard(String vehicleType, int Space) {
    // Replace with actual implementation of slot card
    return Container(
        width: 100,
        height: 100,
        color: Colors.transparent,
        child: Column(
          children: [
            vehicleType == 'Car'
                ? const Icon(
                    Icons.two_wheeler,
                    size: 75,
                  )
                : const Icon(
                    Icons.directions_car,
                    size: 75,
                  ),
            vehicleType == 'Car'
                ? Text('Avalabilty : $Space')
                : Text('Avalabilty : $Space')
          ],
        ));
  }

  Widget _buildBookingCard({
    required String userName,
    // required String parkingTime,
    // required String checkoutTime,
    // required String vehicleType,
  }) {
    return Card(
      elevation: 2,
      shadowColor: grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Text(
                //   "Check In Time :$parkingTime",
                //   style: const TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey,
                //   ),
                // ),
                // Text(
                //   "Estimated Check out Time :$checkoutTime",
                //   style: const TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
            // const Spacer(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text(
            //       vehicleType,
            //       style: const TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     const SizedBox(height: 8),
            //     const SizedBox(height: 8),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
