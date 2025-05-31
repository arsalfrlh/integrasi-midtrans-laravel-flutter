import 'package:http/http.dart' as http;
import 'dart:convert';

class MidtransService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>> paymentBank(String name, String email, int total, String bankTransfer)async{
    final response = await http.post(Uri.parse('$baseUrl/payment/bank'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'name': name, 'email': email, 'gross_amount': total, 'bank_transfer': bankTransfer, 'payment_type': 'bank_transfer'}));
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> paymentGopay(String name, String email, int total)async{
    final response = await http.post(Uri.parse('$baseUrl/payment/gopay'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'name': name, 'email': email, 'gross_amount': total, 'payment_type': 'gopay'}));
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> cekStatusGopay(String status)async{ //cek status langsung midtrans
    const serverKey = 'SB-Mid-server-6GJKV_t1Uh5PpGxjx-JZkPk_';
    final response = await http.get(Uri.parse(status),
    headers: {'Authorization': base64Encode(utf8.encode('$serverKey:'))});
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> cekPaymentGopay(String status)async{ //cek status diserver
    final response = await http.post(Uri.parse('$baseUrl/payment/status/gopay'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'status': status}));
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> paymentCstore(String name, String email, int total, String store, String? message)async{
    final response = await http.post(Uri.parse('$baseUrl/payment/cstore'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'name': name, 'email': email, 'gross_amount': total, 'payment_type': 'cstore', 'store': store, 'message': message}));
    return json.decode(response.body);
  }
}
