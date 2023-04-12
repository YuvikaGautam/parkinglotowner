import 'package:flutter/material.dart';
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

  Future<void> _scanQRCode() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scanner()),
    );
    setState(() {
      uniqueCode = result;
      print('uniqueCode: $uniqueCode');
    });
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSlotCard('Car'),
                        _buildSlotCard('Bike'),
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
                          const Text('Scan QR Code',
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return _buildBookingCard(
                      userName: 'DL 8CW 432$index',
                      parkingTime: '12:00 PM',
                      checkoutTime: '1:00 PM',
                      vehicleType: 'Car',
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildSlotCard(String vehicleType) {
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
                ? const Text('Avalabilty : 10')
                : const Text('Avalabilty : 5')
          ],
        ));
  }

  Widget _buildBookingCard({
    required String userName,
    required String parkingTime,
    required String checkoutTime,
    required String vehicleType,
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
                Text(
                  "Check In Time :$parkingTime",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Estimated Check out Time :$checkoutTime",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  vehicleType,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
