import 'package:flutter/material.dart';
import 'package:payment/pages/bank_page.dart';
import 'package:payment/pages/gopay_page.dart';
import 'package:payment/pages/home_page.dart';
import 'package:payment/pages/qr_code_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Midtrans',
      home: HomePage(),
    );
  }
}
