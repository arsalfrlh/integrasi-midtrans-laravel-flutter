import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:midtrans/models/bank.dart';
import 'package:midtrans/models/cstore.dart';
import 'package:midtrans/models/gopay.dart';
import 'package:midtrans/pages/payment/bank_page.dart';
import 'package:midtrans/pages/payment/cstore_page.dart';
import 'package:midtrans/pages/payment/gopay_page.dart';
import 'package:midtrans/services/midtrans_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final MidtransService midtransService = MidtransService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final paymentTypeController = TextEditingController();
  final totalController = TextEditingController();
  final bankTransferController = TextEditingController();
  final storeController = TextEditingController();
  final messageController = TextEditingController();

  final Map<String, String> paymentOptions = {
    'bank_transfer': 'Transfer Bank',
    'gopay': 'QRIS',
    'cstore': 'CStore'
  };

  final Map<String, String> bankOptions = {
    'bca': 'Bank Central Asia',
    'bri': 'Bank Rakyat IND',
    'bni': 'Bank Negara IND',
    'cimb': 'CIMB Niaga',
  };

  final Map<String, String> storeOptions = {
    'alfamart': 'Alfamaret',
    'indomaret': 'Indomaret',
  };

  void _createPayment(BuildContext context) async {
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty && paymentTypeController.text.isNotEmpty && totalController.text.isNotEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),));

      final response = await midtransService.createPayment(
        nameController.text,
        emailController.text,
        paymentTypeController.text,
        totalController.text,
        bankTransferController.text,
        storeController.text,
        messageController.text);
      Navigator.of(context, rootNavigator: true).pop();

      if(response['transaction_status'] == 'pending'){
        if(response['payment_type'] == 'bank_transfer'){
          final newPayment = Bank(
            orderID: response['order_id'],
            transaksiID: response['transaction_id'],
            codePayment: response['va_numbers'][0]['va_number'],
            total: response['gross_amount'],
            transaksi: DateTime.parse(response['transaction_time']),
            expired: DateTime.parse(response['expiry_time']),
            bank: response['va_numbers'][0]['bank']
          );

          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
            title: 'Sukses',
            desc: response['status_message'],
            btnOkOnPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BankPage(bank: newPayment)));
            }
          ).show();
        }else if(response['payment_type'] == 'cstore'){
          final newPayment = Cstore(
            orderID: response['order_id'],
            transaksiID: response['transaction_id'],
            codePayment: int.parse(response['payment_code']),
            total: response['gross_amount'],
            transaksi: DateTime.parse(response['transaction_time']),
            expired: DateTime.parse(response['expiry_time']),
            store: response['store'],
          );

          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
            title: 'Sukses',
            desc: response['status_message'],
            btnOkOnPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CstorePage(cstore: newPayment)));
            }
          ).show();
        }else if(response['payment_type'] == 'gopay'){
          final newPayment = Gopay(
            orderID: response['order_id'],
            transaksiID: response['transaction_id'],
            total: response['gross_amount'],
            transaksi: DateTime.parse(response['transaction_time']),
            expired: DateTime.parse(response['expiry_time']),
            gambar: response['actions'][0]['url'],
            status: response['actions'][2]['url'],
          );

          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
            title: 'Sukses',
            desc: response['status_message'],
            btnOkOnPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GopayPage(gopay: newPayment)));
            }
          ).show();
        }else{
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            title: 'Error',
            desc: response['status_message'],
            btnOkOnPress: (){}
          ).show();
        }
      }
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        title: 'Error',
        desc: "Mohon isi semua fieldnya",
        btnOkOnPress: (){}
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        title: const Text("Data Pembeli"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  UserInfoEditField(
                    text: "Name",
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Email",
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Jumlah Harga",
                    child: TextFormField(
                      controller: totalController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Metode Pembayaran",
                    child: DropdownButtonFormField<String>(
                      value: paymentTypeController.text.isNotEmpty //jika isi controllernya tdk kosong isi value dropdown adlh controller| jika tdk kosong akan null
                        ? paymentTypeController.text
                        : null,
                      items: paymentOptions.entries.map((entry) { //tipe data Map bankOptions
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        setState((){
                          paymentTypeController.text = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5, vertical: 16.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                      hint: const Text("Metode Pembayaran"),
                    ),
                  ),
                  if(paymentTypeController.text == 'cstore')
                  UserInfoEditField(
                    text: "Store",
                    child: DropdownButtonFormField<String>(
                      value: storeController.text.isNotEmpty //jika isi controllernya tdk kosong isi value dropdown adlh controller| jika tdk kosong akan null
                        ? storeController.text
                        : null,
                      items: storeOptions.entries.map((entry) { //tipe data Map bankOptions
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        setState((){
                          storeController.text = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5, vertical: 16.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                      hint: const Text("Pilih Cstore"),
                    ),
                  ),
                  if(paymentTypeController.text == 'cstore')
                  UserInfoEditField(
                    text: "Pesan",
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0 * 1.5, vertical: 16.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                  ),
                  if(paymentTypeController.text == 'bank_transfer')
                  UserInfoEditField(
                    text: "Bank Transfer",
                    child: DropdownButtonFormField<String>(
                      value: bankTransferController.text.isNotEmpty //jika isi controllernya tdk kosong isi value dropdown adlh controller| jika tdk kosong akan null
                        ? bankTransferController.text
                        : null,
                      items: bankOptions.entries.map((entry) { //tipe data Map bankOptions
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (String? newValue){
                        setState((){
                          bankTransferController.text = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5, vertical: 16.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                      hint: const Text("Pilih Bank"),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BF6D),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () => _createPayment(context),
                    child: const Text("Bayar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}