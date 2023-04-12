import 'package:flutter/material.dart';
import 'package:parkinglotowner/providers/auth.dart';
import 'package:parkinglotowner/providers/loading.dart';
import 'package:parkinglotowner/providers/login.dart';
import 'package:parkinglotowner/registerations/verification.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:parkinglotowner/utilities/appBar.dart';
import 'package:parkinglotowner/utilities/constant.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Parking Lot Owner',
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 30),
          child: FutureBuilder(
            future: loadVerificationStatus(authProvider.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Column(
                    children: [
                      const SizedBox(height: 25),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: grey,
                              child: const Icon(Icons.person,
                                  size: 75,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Bug Smashers',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.verified, color: Colors.green)
                          ]),
                      const SizedBox(height: 16),
                      const SizedBox(height: 25),
                      ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Edit Profile'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.payment),
                          title: const Text('Payments'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.help),
                          title: const Text('Help and Support'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            logout(context);
                          }),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(height: 25),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: grey,
                              child: const Icon(Icons.person,
                                  size: 75,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Bug Smashers',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.report, color: Colors.red)
                          ]),
                      const SizedBox(height: 16),
                      const SizedBox(height: 25),
                      ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Edit Profile'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.verified_user),
                          title: AuthProvider().underVerifyProcess
                              ? const Text('Under Verification')
                              : const Text('Verify Account'),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return VerificationPage();
                              },
                            ));
                          }),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.payment),
                          title: const Text('Payments'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.help),
                          title: const Text('Help and Support'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            logout(context);
                          }),
                    ],
                  );
                }
              } else {
                return Loading();
              }
            },
          ),
        ));
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await context.read<AuthProvider>().logout();
    SnackBar snackBar = const SnackBar(
      content: Text("Logged out successfully"),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }
}
