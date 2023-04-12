import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:path_provider/path_provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedin = false;
  bool _loading = true;
  bool _underVerifyProcess = false;
  String _email = "";
  String _password = "";
  String _userId = "";
  bool get underVerifyProcess => _underVerifyProcess;
  bool get isLoggedin => _isLoggedin;
  String get email => _email;
  String get password => _password;
  String get userId => _userId;
  bool get loading => _loading;
  set underVerifyProcess(bool value) {
    _underVerifyProcess = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  Future<void> initAuth() async {
    const storage = FlutterSecureStorage();
    try {
      _email = await storage.read(key: "email") ?? "";
      _password = await storage.read(key: "password") ?? "";
      _userId = await storage.read(key: "uid") ?? "";
    } catch (e) {
      _email = _password = _userId = "";
      print(e);
    }
    if (_email != "") {
      _isLoggedin = true;
    } else {
      _isLoggedin = false;
    }
    _loading = false;
    notifyListeners();
  }

  Future<String> signUp(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;
      const storage = FlutterSecureStorage();

      // Create user with email and password
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user information to Firestore
      await firestore.collection("users").doc(result.user!.uid).set({
        "email": email,
        "uid": result.user!.uid,
        "password": password,
      });
      final doc =
          await firestore.collection("users").doc(result.user!.uid).get();
      _userId = doc.get("uid");
      userId = _userId;
      print('----------------------------------');
      print(result);
      print('----------------------------------');
      print(result.user!.uid);
      print('----------------------------------');
      print(_userId);
      print('----------------------------------');

      // Sign in user
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user credentials securely
      await storage.write(key: "email", value: email);
      await storage.write(key: "password", value: password);
      await storage.write(key: "userId", value: _userId);
      notifyListeners();
      // Return success message
      return "Signed up successfully!";
    } catch (e) {
      // Return error message
      return "Failed to sign up. Please try again later.";
    }
  }

  Future<String> login(String eMail, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final firestore = FirebaseFirestore.instance;
      const storage = FlutterSecureStorage();

      // Sign in user with email and password
      final result = await auth.signInWithEmailAndPassword(
        email: eMail,
        password: password,
      );
      print('----------------------------------');

      print(result.user!.uid);
      // Retrieve user information from Firestore
      final doc =
          await firestore.collection("users").doc(result.user!.uid).get();
      email = doc.get("email");
      _userId = doc.get("uid");
      userId = _userId;
      // Store user information and credentials securely
      await storage.write(key: "userId", value: _userId);
      await storage.write(key: "email", value: email);
      await storage.write(key: "password", value: password);

      // Notify listeners and return success message
      notifyListeners();
      return "Login success";
    } catch (e) {
      // Notify listeners and return error message
      notifyListeners();
      return "Failed to login. Please try again later.";
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    const storage = FlutterSecureStorage();
    await storage.deleteAll();

    await _deleteCacheDir();
    await _deleteAppDir();
    _email = _password = _userId = "";
    _isLoggedin = false;
    notifyListeners();
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
