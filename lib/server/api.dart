import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

String adminBaseUrl =
    "https://bookingadmin-production.up.railway.app/AdminDetails";

String imageUrl = "https://verificationapi-production-626f.up.railway.app";

Future<bool> addAdminDetails(
  String ownerId,
  String fname,
  String lname,
  String pLotName,
  String paddress,
  String pManagerName,
  int pPhNo,
  int carSpace,
  int bikeSpace,
) async {
  Map data = {
    "ownerId": ownerId,
    "fname": fname,
    "lname": lname,
    "bikeSpace": bikeSpace,
    "carSpace": carSpace,
    "paddress": paddress,
    "isVerified": false,
    "pmanager": pManagerName,
    "pphNo": pPhNo,
    "plotName": pLotName
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

Future<bool> uploadImg(
  String ownerId,
  String img64,
) async {
  Map data = {
    "details": {"img64": img64, "imguploadstatus": true}
  };
  // print(data);
  var response = await http.put(Uri.parse('$adminBaseUrl/updatePhoto/$ownerId'),
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

Future<bool> CheckActivestatus(String checkin) async {
  String userId = checkin.split('&').toString();
  var response = await http.get(Uri.parse('$adminBaseUrl/$userId/tickets'));
  bool result = json.decode(utf8.decode(response.bodyBytes))['activeStatus'];
  if (result) {
    await checkIn(userId);
  }
  else{
    await checkout(userId);
  }
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkIn(String userId) async {
  // String userId = checkin.split('&').toString();
  Map data = {
    "tickets": {"checkinTime": DateTime.now().toString(), "activeStatus": true}
  };

  var response = await http.put(Uri.parse('$adminBaseUrl/Ticket/$userId'),
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

Future<bool> checkout(String checkin) async {
  String userId = checkin.split('&').toString();
  Map data = {
    "tickets": {"checkoutTime": DateTime.now().toString(), "activeStatus": true}
  };

  var response = await http.put(Uri.parse('$adminBaseUrl/Ticket/$userId'),
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
// Future<bool> sendVerification(String image, int encoded) async {
//   Map data = {
//     "placeId": encoded,
//     "img64": image,
//   };
//   print(data);
//   var response = await http.post(Uri.parse('$imageUrl/AddDetails'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(data));
//   print(response.body);
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }

Future<bool> loadVerificationStatus(String ownerId) async {
  http.Response response =
      await http.get(Uri.parse('$adminBaseUrl/GetAdminDetails/$ownerId'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body)['isVerified'];
  } else {
    return false;
  }
}
