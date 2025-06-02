class Cstore {
  final String orderID;
  final String transaksiID;
  final int codePayment;
  final String total;
  final DateTime transaksi;
  final DateTime expired;
  final String store;

  Cstore({required this.orderID, required this.transaksiID, required this.codePayment, required this.total, required this.transaksi, required this.expired, required this.store});
}