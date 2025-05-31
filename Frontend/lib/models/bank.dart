class Bank {
  final String orderID;
  final String bankPayment;
  final int vaNumber;
  final String total;
  final DateTime waktuTransaksi;
  final DateTime Expired;

  Bank({required this.orderID, required this.bankPayment, required this.vaNumber, required this.total, required this.waktuTransaksi, required this.Expired});
  // factory Bank.fromJson(Map<String, dynamic> json) {
  //   return Bank(
  //     orderID: json['order_id'],
  //     bankPayment: json['va_numbers'][0]['bank'],
  //     vaNumber: json['va_numbers'][0]['va_number'],
  //     total: json['gross_amount'],
  //     waktuTransaksi: json['transaction_time'],
  //     Expired: json['expiry_time'],
  //   );
  // }
}
