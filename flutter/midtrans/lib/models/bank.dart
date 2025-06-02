class Bank {
  final String orderID;
  final String transaksiID;
  final String codePayment;
  final String total;
  final DateTime transaksi;
  final DateTime expired;
  final String bank;

  Bank({required this.orderID, required this.transaksiID, required this.codePayment, required this.total, required this.transaksi, required this.expired, required this.bank});
}
