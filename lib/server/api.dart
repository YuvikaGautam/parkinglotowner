import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

String ownerBaseUrl =
    "https://bookingowner-production.up.railway.app/OwnerDetails";
String userBaseUrl =
    "https://userbookingapi-production.up.railway.app/UserBooking";

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
    "ownerdetails": {
      "fname": fname,
      "lname": lname,
      "bikeSpace": bikeSpace,
      "carSpace": carSpace,
      "paddress": paddress,
      "isVerified": false,
      "pmanager": pManagerName,
      "pphNo": pPhNo,
      "plotName": pLotName,
    },
    "tickets": []
  };
  print(data);
  var response = await http.post(Uri.parse('$ownerBaseUrl/AddAdminData'),
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
  var response = await http.put(Uri.parse('$ownerBaseUrl/updatePhoto/$ownerId'),
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

Future<List> getAllTickets(String ownerId) async {
  http.Response response = await http.get(
      Uri.parse('$ownerBaseUrl/Owner/tickets/v3wUROcvk9OBfpCX9ATL4tsqFhk1'));
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    return [];
  }
}

Future<Map> getAvailibiltySpace(String ownerId) async {
  http.Response response = await http
      .get(Uri.parse('$ownerBaseUrl/owners/v3wUROcvk9OBfpCX9ATL4tsqFhk1'));
  print(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    return {};
  }
}

Future<bool> CheckActivestatus(String checkin) async {
  String userId = checkin.split('&').toString();
  var response = await http.get(Uri.parse('$ownerBaseUrl/$userId/tickets'));
  bool result = json.decode(utf8.decode(response.bodyBytes))['activeStatus'];
  if (result) {
    await checkIn(userId);
  } else {
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

  var response = await http.put(Uri.parse('$ownerBaseUrl/Ticket/$userId'),
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

  var response = await http.put(Uri.parse('$ownerBaseUrl/Ticket/$userId'),
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
      await http.get(Uri.parse('$ownerBaseUrl/GetAdminDetails/$ownerId'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body)['isVerified'];
  } else {
    return false;
  }
}

Future<String> getScannedTicket(String ticketNumber) async {
  http.Response response = await http.get(Uri.parse(
      '$ownerBaseUrl/owners/v3wUROcvk9OBfpCX9ATL4tsqFhk1/tickets/$ticketNumber'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body)["ticketId"];
  } else {
    return '';
  }
}

Future<String> getScannedTicketStatus(String ticketNumber) async {
  http.Response response = await http.get(Uri.parse(
      '$ownerBaseUrl/owners/v3wUROcvk9OBfpCX9ATL4tsqFhk1/tickets/$ticketNumber'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body)["ticketStatus"];
  } else {
    return '';
  }
}

Future<String> getScannedTicketUser(String ticketNumber) async {
  http.Response response = await http.get(Uri.parse(
      '$ownerBaseUrl/owners/v3wUROcvk9OBfpCX9ATL4tsqFhk1/tickets/$ticketNumber'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body)["userId"];
  } else {
    return '';
  }
}

Future<bool> updateTicketStatusUser(
    String ticketNumber, String checkoutId) async {
  String ownerId = "v3wUROcvk9OBfpCX9ATL4tsqFhk1";
  // String userId = "621LkZwm6dO9pbaIz9PFu2xSuQ72";
  String userId = await getScannedTicketUser(ticketNumber);
  bool ticketStatus =
      await getScannedTicketStatus(ticketNumber) == "true" ? true : false;
  String ticketId = await getScannedTicket(ticketNumber);
  Map data;
  if (ticketStatus) {
    data = {
      "ticketIdCheckout": checkoutId,
      "activeStatus": true,
      "checkinTime": DateTime.now().toString()
    };
  } else {
    data = {"checkoutTime": DateTime.now().toString()};
  }
  http.Response response =
      await http.patch(Uri.parse('$userBaseUrl/UpdateTicket/$userId/$ticketId'),
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
