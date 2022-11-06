import 'package:flutter/material.dart';
import 'package:parkinglotowner/registerations/details.dart';
import 'package:parkinglotowner/registerations/verification.dart';
import 'package:parkinglotowner/registerations/waiting.dart';
import 'package:parkinglotowner/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/auth.dart';
import 'providers/loading.dart';
import 'providers/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().initAuth();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white)),
        ),
        home: context.watch<AuthProvider>().loading
            ? const Loading()
            : context.watch<AuthProvider>().isLoggedin
                ? (context.watch<AuthProvider>().isdetailsVerified
                    ? const HomePage()
                    : const Waiting())
                : const LoginPage());
  }
}
