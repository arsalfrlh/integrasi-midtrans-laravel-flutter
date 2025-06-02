import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MidtransService {
  final String baseUrl = 'https://api.sandbox.midtrans.com/v2/charge';
  final String serverKey = 'SB-Mid-server-6GJKV_t1Uh5PpGxjx-JZkPk_';

  String createOrderID() { //function utk membuat order id acak
    final random = Random().nextInt(10000);
    final orderID = 'Order-$random';

    return orderID;
  }

  String getFormattedOrderTime() { //function utk membuat costum expired pembayaran
    final now = DateTime.now();
    final timeZoneOffset = now.timeZoneOffset;
    final sign = timeZoneOffset.isNegative ? '-' : '+';
    final hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (timeZoneOffset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final formattedOffset = '$sign$hours$minutes';
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(now) + ' ' + formattedOffset;
  }


  Future<Map<String, dynamic>> createPayment(
      String name,
      String email,
      String paymentType,
      String total,
      String? bankTransfer,
      String? store,
      String? message) async {
    if (paymentType == 'bank_transfer') {
      final response = await http.post(Uri.parse('$baseUrl'),
          headers: {
            'Authorization': base64Encode(utf8.encode('$serverKey:')),
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              "payment_type": paymentType,
              "transaction_details": {
                "order_id": createOrderID(),
                "gross_amount": total,
              },
              "bank_transfer": {
                "bank": bankTransfer,
              },
              "customer_details": {
                "first_name": name,
                "email": email,
              },
              "custom_expiry": {
                "order_time": getFormattedOrderTime(),
                "expiry_duration": 24,
                "unit": "hour"
              },
            },
          ));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment: ${response.body}');
      }
    } else if (paymentType == 'cstore') {
      final response = await http.post(Uri.parse('$baseUrl'),
          headers: {
            'Authorization': base64Encode(utf8.encode('$serverKey:')),
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              "payment_type": paymentType,
              "transaction_details": {
                "order_id": createOrderID(),
                "gross_amount": total,
              },
              "cstore": {
                "store": store,
                "message": message,
              },
              "customer_details": {
                "first_name": name,
                "email": email,
              },
            },
          ));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment: ${response.body}');
      }
    } else if (paymentType == 'gopay') {
      final response = await http.post(Uri.parse('$baseUrl'),
          headers: {
            'Authorization': base64Encode(utf8.encode('$serverKey:')),
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              "payment_type": paymentType,
              "transaction_details": {
                "order_id": createOrderID(),
                "gross_amount": total,
              },
              "customer_details": {
                "first_name": name,
                "email": email,
              },
            },
          ));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment: ${response.body}');
      }
    } else {
      Map<String, dynamic> response = {
        'transaction_status': 'failed',
        'status_message': 'Mohon maaf aplikasi sedang error, Coba lagi',
      };
      return response;
    }
  }

  Future<Map<String, dynamic>> cekStatus(String transaksiID)async{
    final response = await http.get(Uri.parse('https://api.sandbox.midtrans.com/v2/$transaksiID/status'),
    headers: {'Authorization': base64Encode(utf8.encode('$serverKey:'))
    });
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to create payment: ${response.body}');
    }
  }
}
