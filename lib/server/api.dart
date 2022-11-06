import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

String adminBaseUrl =
    "https://admin-details-bookmyslot.herokuapp.com/AdminDetails";

String imageUrl =
    "https://verification-api-bookmyslot.herokuapp.com";
Future<bool> addAdmin(
  int encoded,
  String fname,
  String lname,
  String parkingLot,
  String paddress,
  String pname,
  int pPhone,
  int carSpace,
  int bikeSpace,
) async {
  Map data = {
    "placeId": encoded,
    "fnameofowner": fname,
    "lnameofowner": lname,
    "parkingLot": parkingLot,
    "address": paddress,
    "parkingManager": pname,
    "parkingPhNo": pPhone,
    "carSpace": carSpace,
    "bikeSpace": bikeSpace,
    "email": "email",
    "password": "password",
    "IsVerified": false,
  };
  print(data);
  var response = await http.post(Uri.parse('$adminBaseUrl/AddAdminData'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data));
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> sendVerification(String image, int encoded) async {
  Map data = {
    "placeId": encoded,
    "img64": image,
  };
  print(data);
  var response = await http.post(Uri.parse('$imageUrl/AddDetails'),
      headers: {
        'Content-Type': 'application/json',
      }, 
      body: json.encode(data));
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
Future<bool> checkVerification(String encoded) async {
  http.Response response =
      await http.get(Uri.parse('$adminBaseUrl/GetAdminDetails/$encoded'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body)['isVerified'];
  } else {
    return false;
  }
}

