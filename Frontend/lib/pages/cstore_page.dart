import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:payment/models/cstore.dart';
import 'package:payment/pages/payment_cstore_page.dart';
import 'package:payment/services/midtrans_service.dart';

class CstorePage extends StatefulWidget {
  const CstorePage({super.key});

  @override
  State<CstorePage> createState() => _CstorePageState();
}

class _CstorePageState extends State<CstorePage> {
  final MidtransService midtransService = MidtransService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final totalController = TextEditingController();
  final storeController = TextEditingController();
  final messageController = TextEditingController();

  final Map<String, String> storeOptions = { //option dropdown| sama seperti (select| option) di html
    'alfamart': 'Alfamaret',
    'indomaret': 'Indomaret',
  };

  void _createPayment(BuildContext context)async{
    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && totalController.text.isNotEmpty && storeController.text.isNotEmpty){
        showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),));
      
        final response = await midtransService.paymentCstore(nameController.text, emailController.text, int.parse(totalController.text), storeController.text, messageController.text);
        Navigator.of(context, rootNavigator: true).pop();
        if(response['success'] == true){
          final data = response['data'];

          // final paymentCstore = Cstore(
          //   orderID: data['order_id'],
          //   store: data['store'],
          //   paymentCode: data['payment_code'],
          //   total: data['gross_amount'],
          //   waktuTransaksi: data['transaction_time'],
          //   expired: data['expiry_time'],
          // );
          
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            dismissOnTouchOutside: false,
            title: 'Sukses',
            desc: response['message'],
            btnOkOnPress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaymentCstorePage(cstore: data);
              }));
            },
          ).show();
        }else{
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            title: 'Error',
            desc: response['message'],
            btnOkOnPress: (){},
          ).show();
        }
    }else{
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        title: 'Error',
        desc: 'Mohon isi semua fieldnya',
        btnOkOnPress: (){},
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
                    text: "Harga",
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
                  UserInfoEditField(
                  text: "Store",
                  child: DropdownButtonFormField<String>(
                    value: storeController.text.isNotEmpty
                        ? storeController.text
                        : null,
                    items: storeOptions.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
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
                    hint: const Text("Pilih Store"),
                  ),
                ),

                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.08),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
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