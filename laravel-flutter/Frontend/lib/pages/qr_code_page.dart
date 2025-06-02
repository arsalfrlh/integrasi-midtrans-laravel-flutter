import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  @override
  void initState() {
    super.initState();
    // Menonaktifkan verifikasi SSL
    HttpOverrides.global = MyHttpOverrides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code")),
      body: Center(
        child: Image.network('https://api.sandbox.midtrans.com/v2/gopay/d65d509d-b16e-44ab-a56e-fa648e1b8387/qr-code'),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}