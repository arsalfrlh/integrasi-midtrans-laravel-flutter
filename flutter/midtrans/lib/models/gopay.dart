class Gopay {
  final String orderID;
  final String transaksiID;
  final String total;
  final DateTime transaksi;
  final DateTime expired;
  final String gambar;
  final String status;

  Gopay({required this.orderID, required this.transaksiID, required this.total, required this.transaksi, required this.expired, required this.gambar, required this.status});
}