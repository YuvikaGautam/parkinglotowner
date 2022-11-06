import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parkinglotowner/server/api.dart';
import 'package:path_provider/path_provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedin = false;
  bool _loading = true;
  bool _isImgSubmitted = false;
  bool _isdetailsEntered = false;
  bool _isdetailsVerified = false;
  // bool _submitted = false;
  String _email = "";
  String _password = "";
  String _encoded = "";
  String _uid = "";
  // bool get submitted => _submitted;
  bool get isLoggedin => _isLoggedin;
  bool get isdetailsEntered => _isdetailsEntered;
  bool get isImgSubmitted => _isImgSubmitted;
  bool get isdetailsVerified => _isdetailsVerified;
  String get email => _email;
  String get password => _password;
  String get encoded => _encoded;
  String get uid => _uid;
  bool get loading => _loading;

  Future<void> initAuth() async {
    const storage = FlutterSecureStorage();
    try {
      _email = await storage.read(key: "email") ?? "";
      _password = await storage.read(key: "password") ?? "";
      _encoded = await storage.read(key: "encoded") ?? "";
      _uid = await storage.read(key: "uid") ?? "";
      _isImgSubmitted = await storage.read(key: "isImgSubmitted") == "true";
      _isdetailsVerified = false;
      // _isdetailsVerified = await checkVerification(int.parse(_encoded));
    } catch (e) {
      _email = _password = _uid = "";
      print(e);
    }
    if (_email != "" && _isdetailsVerified) {
      _isdetailsVerified = true;
    } else if (_email != "") {
      _isLoggedin = true;
    } else {
      _isLoggedin = false;
    }
    // _isLoggedin = _email != "" ? true : false;
    _loading = false;
    notifyListeners();
  }

  Future<void> detailsEntered(int encoded) async {
    const storage = FlutterSecureStorage();
    storage.write(key: "encoded", value: encoded.toString());
    // _isdetailsEntered = true;
    notifyListeners();
  }

  // Future<void> imageSubmitted() async {
  //   const storage = FlutterSecureStorage();
  //   _isImgSubmitted = true;
  //   storage.write(key: "isImgSubmitted", value: "true");
  //   notifyListeners();
  // }

  // Future<void> isVerified() async {
  //   const storage = FlutterSecureStorage();
  //   _isdetailsVerified = true;
  //   storage.write(key: "isdetailsVerified", value: "true");
  //   notifyListeners();
  // }

  Future<String> signUp(String email, String password) async {
    final auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    const storage = FlutterSecureStorage();
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _uid = result.user!.uid;
      _email = email;
      _password = password;
      await firebaseFirestore.collection("admins").doc(_uid).set({
        "email": email,
        "uid": _uid,
      });
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _isLoggedin = true;
      notifyListeners();
      return "Signed Up";
    } catch (e) {
      return "Something went wrong please try again";
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      const storage = FlutterSecureStorage();
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      _uid = result.user!.uid;
      await firebaseFirestore
          .collection("admins")
          .doc(_uid)
          .get()
          .then((value) {
        _uid = value.data()!["uid"];
      });
      _isLoggedin = true;
      storage.write(key: "email", value: email);
      storage.write(key: "password", value: password);

      storage.write(key: "uid", value: _uid);
      print('=====================================');
      print('auth');

      print(_uid);
      print(_email);
      print('=====================================');

      notifyListeners();
      return "Login Success";
    } catch (e) {
      _isLoggedin = false;
      return "Login Failed";
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    const storage = FlutterSecureStorage();
    await storage.deleteAll();

    await _deleteCacheDir();
    await _deleteAppDir();
    _email = _password = _uid = "";
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
